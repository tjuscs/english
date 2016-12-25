package com.demo.biz.admin;


import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.News;
import com.demo.common.util.UUIDUtil;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by yanz on 2016/10/13.
 */
@Before({AuthInterceptor.class})
public class FileController extends Controller {

    public void upload() {
        News n = News.dao.findById(getParaToInt());
        String uploadPath = getFile().getUploadPath();

        File file = new File(uploadPath + File.separator + n.getImg());
        if (file.exists()) {
            FileUtils.deleteQuietly(file);
        }

        String fileName = getFile().getFileName();
        String newName = UUIDUtil.getUUID() + fileName.substring(fileName.lastIndexOf("."), fileName.length());
        try {
            File tmpFile = getFile().getFile();
            FileUtils.copyFile(tmpFile, new FileOutputStream(new File(uploadPath + File.separator + newName)));
            FileUtils.deleteQuietly(tmpFile);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        n.setImg(newName);
        n.update();
        renderJson();
    }

}
