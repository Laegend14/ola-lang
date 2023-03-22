use std::collections::HashMap;
use inkwell::IntPredicate;
use inkwell::values::{BasicValueEnum, FunctionValue};
use num_bigint::BigInt;
use ola_parser::program::Loc;
use crate::irgen::binary::Binary;
use crate::irgen::expression::expression;
use crate::sema::ast::{Expression, Function, Namespace, Type};
use crate::sema::ast::Expression::NumberLiteral;


pub fn u32_add<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns);
    let right = expression(r, bin, func, func_val, var_table, ns);
    let result: BasicValueEnum = bin.builder
        .build_int_add(left.into_int_value(), right.into_int_value(), "")
        .into();
    bin.builder.build_call(
            bin.module
                .get_function("builtin_range_check")
                .expect("builtin_range_check should have been defined before"),
            &[result.into()],
            "",
        );
    result
}


pub fn u32_sub<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns);
    let right = expression(r, bin, func, func_val, var_table, ns);
    let result: BasicValueEnum = bin.builder
        .build_int_sub(left.into_int_value(), right.into_int_value(), "")
        .into();
    bin.builder.build_call(
        bin.module
            .get_function("builtin_range_check")
            .expect("builtin_range_check should have been defined before"),
        &[result.into()],
        "",
    );
    result
}

pub fn u32_mul<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns);
    let right = expression(r, bin, func, func_val, var_table, ns);
    let result: BasicValueEnum = bin.builder
        .build_int_mul(left.into_int_value(), right.into_int_value(), "")
        .into();
    bin.builder.build_call(
        bin.module
            .get_function("builtin_range_check")
            .expect("builtin_range_check should have been defined before"),
        &[result.into()],
        "",
    );
    result
}

pub fn u32_div<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    unimplemented!()
}

pub fn u32_mod<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    unimplemented!()
}

pub fn u32_bitwise_or<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder.build_or(left, right, "").into()
}

pub fn u32_bitwise_and<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder.build_and(left, right, "").into()
}

pub fn u32_bitwise_xor<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder.build_xor(left, right, "").into()
}

pub fn u32_shift_left<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    unimplemented!()
}

pub fn u32_shift_right<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    unimplemented!()
}

pub fn u32_equal<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::EQ, left, right, "")
        .into()
}

pub fn u32_not_equal<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::NE, left, right, "")
        .into()
}

pub fn u32_more<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::UGT, left, right, "")
        .into()
}

pub fn u32_more_equal<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::UGE, left, right, "")
        .into()
}

pub fn u32_less<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::ULT, left, right, "")
        .into()
}

pub fn u32_less_equal<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let left = expression(l, bin, func, func_val, var_table, ns).into_int_value();
    let right = expression(r, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::ULE, left, right, "")
        .into()
}

pub fn u32_not<'a>(
    expr: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let e = expression(expr, bin, func, func_val, var_table, ns).into_int_value();

    bin.builder
        .build_int_compare(IntPredicate::EQ, e, e.get_type().const_zero(), "")
        .into()
}

pub fn u32_complement<'a>(
    expr: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    let u32_max = NumberLiteral(Loc::IRgen, Type::Uint(32), BigInt::from(u32::MAX));
    u32_sub(&u32_max, expr, bin, func, func_val, var_table, ns)
}

pub fn u32_or<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {

    // Generate code for the left and right expressions
    let left_value = expression(l, bin, func, func_val, var_table, ns).into_int_value();

    let bool_type = bin.context.bool_type();
    // Create basic blocks for the OR expression
    let current_bb = bin.builder.get_insert_block().unwrap();
    let left_true_bb = bin.context.append_basic_block(func_val, "left_true");
    let right_true_bb = bin.context.append_basic_block(func_val, "right_true");
    let merge_bb = bin.context.append_basic_block(func_val, "merge");
    bin.builder.position_at_end(current_bb);

    // Create a temporary variable to store the result
    let result_ptr = bin.builder.build_alloca(bool_type, "");

    // Generate the OR expression using basic blocks
    bin.builder.build_conditional_branch(left_value, left_true_bb, right_true_bb);

    bin.builder.position_at_end(left_true_bb);
    bin.builder.build_store(result_ptr, left_value);
    bin.builder.build_unconditional_branch(merge_bb);

    bin.builder.position_at_end(right_true_bb);
    let right_value = expression(r, bin, func, func_val, var_table, ns).into_int_value();
    bin.builder.build_store(result_ptr, right_value);
    bin.builder.build_unconditional_branch(merge_bb);

    bin.builder.position_at_end(merge_bb);
    let result = bin.builder.build_load(result_ptr, "");

    result
}

pub fn u32_and<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    // Generate code for the left and right expressions
    let left_value = expression(l, bin, func, func_val, var_table, ns).into_int_value();

    let bool_type = bin.context.bool_type();
    // Create basic blocks for the OR expression
    let current_bb = bin.builder.get_insert_block().unwrap();
    let left_false_bb = bin.context.append_basic_block(func_val, "left_false");
    let right_false_bb = bin.context.append_basic_block(func_val, "right_false");
    let merge_bb = bin.context.append_basic_block(func_val, "merge");
    bin.builder.position_at_end(current_bb);

    // Create a temporary variable to store the result
    let result_ptr = bin.builder.build_alloca(bool_type, "");

    // Generate the OR expression using basic blocks
    bin.builder.build_conditional_branch(left_value, right_false_bb, left_false_bb);

    bin.builder.position_at_end(left_false_bb);
    bin.builder.build_store(result_ptr, left_value);
    bin.builder.build_unconditional_branch(merge_bb);

    bin.builder.position_at_end(right_false_bb);
    let right_value = expression(r, bin, func, func_val, var_table, ns).into_int_value();
    bin.builder.build_store(result_ptr, right_value);
    bin.builder.build_unconditional_branch(merge_bb);

    bin.builder.position_at_end(merge_bb);
    let result = bin.builder.build_load(result_ptr, "");

    result
}

pub fn u32_power<'a>(
    l: &Expression,
    r: &Expression,
    bin: &Binary<'a>,
    func: Option<&Function>,
    func_val: FunctionValue<'a>,
    var_table: &mut HashMap<usize, BasicValueEnum<'a>>,
    ns: &Namespace,
) -> BasicValueEnum<'a> {
    unimplemented!()
}

