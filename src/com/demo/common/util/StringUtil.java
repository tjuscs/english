package com.demo.common.util;

import com.jfinal.kit.StrKit;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by yanz on 2016/10/12.
 */
public class StringUtil extends StrKit {

    private static Pattern p = Pattern.compile("([A-Z])");

    public static String camel2Underscore(String str) {
        Matcher m = p.matcher(str);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            m.appendReplacement(sb, "_" + m.group(1).toLowerCase());
        }
        m.appendTail(sb);
        return sb.toString();
    }
}
