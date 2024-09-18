package com.example.testtaskcompany.utils;

import org.hibernate.dialect.PostgreSQLDialect;

public class PostgreSQLDialectExtended extends PostgreSQLDialect {

    public PostgreSQLDialectExtended() {
        super();
        registerKeyword("filter");
        registerKeyword("alias_");
    }
}