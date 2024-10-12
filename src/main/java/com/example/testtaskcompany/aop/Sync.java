package com.example.testtaskcompany.aop;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.concurrent.TimeUnit;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;

@Target(value = {PARAMETER, METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface Sync {


    long time() default 120;

    TimeUnit timeUnit() default TimeUnit.SECONDS;

}
