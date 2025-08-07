package com.motiveon.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class CalendarVO {

    private String ccode;
    private String catecode;
    private String title;
    private String content;

    // 프런트에서 받는 원본 문자열
    private String start;
    private String end;

    // DB 바인딩용
    private Date sdate;
    private Date edate;

    private int eno;
    private String color = "";
    private String catedetail = "";

    // ---- 문자열 -> Date 변환은 여기서만 ----
    private static final String[] DATE_PATTERNS = {
        "yyyy-MM-dd'T'HH:mm",
        "yyyy-MM-dd HH:mm",
        "EEE MMM dd HH:mm:ss z yyyy"  // Java Date.toString()
    };

    private Date tryParseDate(String value) {
        if (value == null || value.isEmpty()) return null;
        for (String p : DATE_PATTERNS) {
            try {
                // 영어 월/요일 대비 위해 ENGLISH 사용
                SimpleDateFormat sdf = new SimpleDateFormat(p, Locale.ENGLISH);
                return sdf.parse(value);
            } catch (ParseException ignored) {}
        }
        return null;
    }

    public void setStart(String start) {
        this.start = start;
        this.sdate = tryParseDate(start);
    }

    public void setEnd(String end) {
        this.end = end;
        this.edate = tryParseDate(end);
    }

    public String getStart() { return start; }
    public String getEnd()   { return end;   }

    public Date getSdate() { return sdate; }
    public Date getEdate() { return edate; }

    // DB -> 객체 바인딩 시 사용
    public void setSdate(Date sdate) { this.sdate = sdate; }
    public void setEdate(Date edate) { this.edate = edate; }

    public String getCcode() { return ccode; }
    public void setCcode(String ccode) { this.ccode = ccode; }

    public String getCatecode() { return catecode; }
    public void setCatecode(String catecode) { this.catecode = catecode; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getEno() { return eno; }
    public void setEno(int eno) { this.eno = eno; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = (color == null) ? "" : color; }

    public String getCatedetail() { return catedetail; }
    public void setCatedetail(String catedetail) { this.catedetail = (catedetail == null) ? "" : catedetail; }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}

