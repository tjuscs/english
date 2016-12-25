package com.demo.biz.teacher;

import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.biz.interceptors.MenuInterceptors;
import com.demo.biz.interceptors.SubMenuInterceptor;
import com.demo.biz.interceptors.TeacherAuthInterceptor;
import com.demo.common.model.User;
import com.demo.common.model.UserAward;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.ehcache.CacheKit;
import org.apache.commons.codec.digest.DigestUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by yanz on 2016/10/12.
 */
@Before(MenuInterceptors.class)
public class TeacherController extends Controller {

    public static final String TEACHER_KEY = "teacher_key";

    @Before(SubMenuInterceptor.class)
    public void index() {
        //查看杰出人才
        if (getParaToInt() == 25) {
            setAttr("strategy", "award");
            //变量名需要重新设计
            Object res = CacheKit.get("teacher", "bestTeacher", () -> {
                Map<String, List<User>> result = new LinkedHashMap<>();
                List<User> bt = User.dao.find("select id, account, name, user_award.award_id, user_award.award_name from user, user_award where `user`.id = user_award.user_id and user_award.award_id > 0 and `user`.verified = 1 order by order_index asc,  job_title desc, account asc");
                Map<String, List<User>> t = bt.stream().collect(Collectors.groupingBy(u -> User.award(u.get("award_id"))));
                t.entrySet().stream().sorted(Comparator.comparingInt(o -> o.getValue().get(0).<Long>get("award_id").intValue())).forEachOrdered(x -> result.put(x.getKey(), x.getValue()));
                return result;
            });
            setAttr("teachers", res);
        } else if (getParaToInt() == 22) {  //查看教师简介
            setAttr("strategy", "jobTitle");
            Object res = CacheKit.get("teacher", "allTeacher", () -> {
                Map<String, List<User>> result = new LinkedHashMap<>();
                List<User> bt = User.dao.find("select id, name, laboratory from user where laboratory is not null and verified = 1 order by order_index asc,  job_title desc, account asc");
                Map<String, List<User>> t = bt.stream().collect(Collectors.groupingBy(User::laboratory));
                t.entrySet().stream().sorted(Comparator.comparingInt(me -> me.getValue().get(0).getLaboratory())).forEachOrdered(x -> result.put(x.getKey(), x.getValue()));
                return result;
            });
            setAttr("teachers", res);
        } else {
            redirect("/");
        }

        render("award_list.ftl");
    }

    public void detail() {
        User model = User.dao.findById(getParaToInt());
        model.setPassword("");
        model.setAccount("");
        if (model.getVerified() == 1 || model.getId().intValue() == 175 || model.getId().intValue() == 176) {
            setAttr("teacher", model);
            String imgBase64 = JsonKit.toJson(model.getImg());
            String imgSrc = "data:image/jpeg;base64," + imgBase64.substring(1, imgBase64.length() - 1);
            setAttr("photo", imgSrc);
            render("detail.ftl");
        } else {
            renderError(404);
        }
    }

    /**
     * 老师个人详情页面
     */
    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void profile() {
        setAttr("teacher", getSessionAttr(TEACHER_KEY));
    }

    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void getTeacher() {
        User model = getSessionAttr(TEACHER_KEY);
        model = User.dao.findById(model.getId());
        model.remove("password");
        renderJson(model);
    }

    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void saveAward() {
        User model = getSessionAttr(TEACHER_KEY);

        UserAward data = JsonKit.parse(HttpKit.readData(getRequest()), UserAward.class);

        if (data.getAwardId() == null) {
            renderError(404);
            return;
        }

        if (data.getUserId() != null && data.getUserId() == model.getId().intValue()) {
            data.update();
        } else {
            data.setUserId(model.getId());
            data.save();
        }

        renderJson(model);
    }

    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void deleteAward() {
        User model = getSessionAttr(TEACHER_KEY);
        Integer awardId = getParaToInt("awardId");
        try {
            UserAward.dao.deleteById(awardId, model.getId());
        } catch (Exception ex) {
            renderError(404);
        }
    }


    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void saveIntroduction() {
        String introduction = HttpKit.readData(getRequest());
        User model = getSessionAttr(TEACHER_KEY);
        model.setIntroduction(introduction);
        model.update();
        renderJson(introduction);
//
//		model.save();
//		renderJson(model);
    }

    @Before({TeacherAuthInterceptor.class, SessionInViewInterceptor.class})
    public void save() {
        User model = JsonKit.parse(HttpKit.readData(getRequest()), User.class);

        if (StrKit.notBlank(model.getPassword())) {
            model.setPassword(DigestUtils.md5Hex(model.getPassword()));
        } else {
            model.remove("password");
        }

        if (model.getImg() == null || model.getImg().length == 0) {
            model.remove("img");
        }

        model.update();

        model.findById(model.getId());
        setSessionAttr(TEACHER_KEY, model);
        renderJson(model);
    }

    public void login() {
        //验证码
        if (!validateCaptcha("captcha")) {
            renderJson("verify", false);
            return;
        }
        //验证用户登陆是否成功
        Optional<User> teacher = Optional.ofNullable(User.dao.findFirst("select * from user where account = ? and password = md(?)", getPara("user.account"), getPara("user.password")));
        if (teacher.isPresent()) {
            setSessionAttr(TEACHER_KEY, teacher.get());
            renderJson("verify", true);
        } else {
            renderJson("verify", false);
        }
    }

    /**
     * ajax处理用户登出逻辑
     */
//	@ActionKey("/logout")
    @Clear(AuthInterceptor.class)
    public void logout() {
        removeSessionAttr(TEACHER_KEY);
        redirect("/");
    }

}
