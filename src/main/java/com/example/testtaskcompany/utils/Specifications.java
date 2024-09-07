package com.example.testtaskcompany.utils;

import com.example.testtaskcompany.utils.ExpressionSupplier;
import jakarta.persistence.metamodel.SingularAttribute;
import org.springframework.data.jpa.domain.Specification;

public interface Specifications<ENTITY> {

    default Specification<ENTITY> like(ExpressionSupplier<ENTITY, String> attribute, String value) {
        if (value == null) {
            return (root, query, criteriaBuilder) -> null;
        }
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.like(criteriaBuilder.lower(attribute.toExpression(root)), "%" + value.toLowerCase() + "%");
    }

    default <TYPE> Specification<ENTITY> equal(ExpressionSupplier<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return (root, query, criteriaBuilder) -> null;
        }
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(attribute.toExpression(root), value);
    }

    default <TYPE> Specification<ENTITY> equal(SingularAttribute<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return (root, query, criteriaBuilder) -> null;
        }
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.equal(root.get(attribute), value);
    }

    default <TYPE extends Comparable<? super TYPE>> Specification<ENTITY> ge(ExpressionSupplier<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return Specification.where(null);
        }
        return (root, query, criteriaBuilder) -> criteriaBuilder.greaterThanOrEqualTo(attribute.toExpression(root), value);
    }

    default <TYPE extends Comparable<? super TYPE>> Specification<ENTITY> ge(SingularAttribute<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return Specification.where(null);
        }
        return (root, query, criteriaBuilder) -> criteriaBuilder.greaterThanOrEqualTo(root.get(attribute), value);
    }

    default <TYPE extends Comparable<? super TYPE>> Specification<ENTITY> le(ExpressionSupplier<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return (root, query, criteriaBuilder) -> null;
        }
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.lessThanOrEqualTo(attribute.toExpression(root), value);
    }

    default <TYPE extends Comparable<? super TYPE>> Specification<ENTITY> le(SingularAttribute<ENTITY, TYPE> attribute, TYPE value) {
        if (value == null) {
            return (root, query, criteriaBuilder) -> null;
        }
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.lessThanOrEqualTo(root.get(attribute), value);
    }

}
