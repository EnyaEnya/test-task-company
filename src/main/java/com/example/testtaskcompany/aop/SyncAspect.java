package com.example.testtaskcompany.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import static com.example.testtaskcompany.utils.TransactionSemaphore.sync;

@Slf4j
@Aspect
@Component
@Order(-20)
public class SyncAspect {

    @Around("@annotation(condition)")
    public Object lock(ProceedingJoinPoint pjp, Sync condition) {
        return sync(condition.time(), condition.timeUnit(),
                () -> {
                    try {
                        return pjp.proceed();
                    } catch (Throwable e) {
                        if (!(e instanceof RuntimeException)) {
                            log.warn(e.getMessage(), e);
                            throw new RuntimeException(e);
                        } else {
                            throw (RuntimeException) e;
                        }
                    }
                });
    }
}