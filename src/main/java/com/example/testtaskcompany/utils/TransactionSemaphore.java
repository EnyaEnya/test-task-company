package com.example.testtaskcompany.utils;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.function.Supplier;

@Slf4j
public class TransactionSemaphore {

    private static final Semaphore semaphore = new Semaphore(1);

    public static <T> T sync(long time, TimeUnit unit, Supplier<T> supplier) {
        acquire(time, unit);
        try {
            return supplier.get();
        } finally {
            release();
        }
    }

    public static void acquire(long time, TimeUnit unit) {
        try {
            semaphore.tryAcquire(time, unit);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void release() {
        try {
            semaphore.release();
        } catch (Exception ex) {
            log.error(ex.getMessage(), ex);
        }
    }
}
