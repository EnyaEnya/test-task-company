package com.example.testtaskcompany.utils;

import jakarta.persistence.criteria.Expression;
import jakarta.persistence.criteria.Root;

@FunctionalInterface
public interface ExpressionSupplier <ENTITY, TYPE> {

    Expression<TYPE> toExpression(Root<ENTITY> root);

}
