; ModuleID = 'StructWithArrayExample'
source_filename = "examples/source/struct/struct_array.ola"

@heap_address = internal global i64 -4294967353

declare void @builtin_assert(i64)

declare void @builtin_range_check(i64)

define void @mempcy(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  %len_alloca = alloca i64, align 8
  %dest_ptr_alloca = alloca ptr, align 8
  %src_ptr_alloca = alloca ptr, align 8
  store ptr %0, ptr %src_ptr_alloca, align 8
  %src_ptr = load ptr, ptr %src_ptr_alloca, align 8
  store ptr %1, ptr %dest_ptr_alloca, align 8
  %dest_ptr = load ptr, ptr %dest_ptr_alloca, align 8
  store i64 %2, ptr %len_alloca, align 4
  %len = load i64, ptr %len_alloca, align 4
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, %len
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %src_index_access = getelementptr i64, ptr %src_ptr, i64 %index_value
  %3 = load i64, ptr %src_index_access, align 4
  %dest_index_access = getelementptr i64, ptr %dest_ptr, i64 %index_value
  store i64 %3, ptr %dest_index_access, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  ret void
}

declare i64 @prophet_u32_sqrt(i64)

declare i64 @prophet_u32_div(i64, i64)

declare i64 @prophet_u32_mod(i64, i64)

declare ptr @prophet_u32_array_sort(ptr, i64)

declare i64 @vector_new(i64)

declare void @get_context_data(i64, i64)

declare void @get_tape_data(i64, i64)

declare void @set_tape_data(i64, i64)

declare void @get_storage(ptr, ptr)

declare void @set_storage(ptr, ptr)

declare void @poseidon_hash(ptr, ptr, i64)

declare void @contract_call(ptr, i64)

declare void @prophet_printf(i64, i64)

define ptr @createStudent() {
entry:
  %index_alloca = alloca i64, align 8
  %0 = call i64 @vector_new(i64 2)
  %heap_start = sub i64 %0, 2
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  store i64 1, ptr %heap_to_ptr, align 4
  %1 = ptrtoint ptr %heap_to_ptr to i64
  %2 = add i64 %1, 1
  %vector_data = inttoptr i64 %2 to ptr
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, 3
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %index_access = getelementptr i64, ptr %vector_data, i64 %index_value
  store i64 0, ptr %index_access, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  %length = load i64, ptr %heap_to_ptr, align 4
  %3 = sub i64 %length, 1
  %4 = sub i64 %3, 0
  call void @builtin_range_check(i64 %4)
  %5 = ptrtoint ptr %heap_to_ptr to i64
  %6 = add i64 %5, 1
  %vector_data1 = inttoptr i64 %6 to ptr
  %index_access2 = getelementptr i64, ptr %vector_data1, i64 0
  store i64 85, ptr %index_access2, align 4
  %length3 = load i64, ptr %heap_to_ptr, align 4
  %7 = sub i64 %length3, 1
  %8 = sub i64 %7, 1
  call void @builtin_range_check(i64 %8)
  %9 = ptrtoint ptr %heap_to_ptr to i64
  %10 = add i64 %9, 1
  %vector_data4 = inttoptr i64 %10 to ptr
  %index_access5 = getelementptr i64, ptr %vector_data4, i64 1
  store i64 90, ptr %index_access5, align 4
  %length6 = load i64, ptr %heap_to_ptr, align 4
  %11 = sub i64 %length6, 1
  %12 = sub i64 %11, 2
  call void @builtin_range_check(i64 %12)
  %13 = ptrtoint ptr %heap_to_ptr to i64
  %14 = add i64 %13, 1
  %vector_data7 = inttoptr i64 %14 to ptr
  %index_access8 = getelementptr i64, ptr %vector_data7, i64 2
  store i64 95, ptr %index_access8, align 4
  %15 = call i64 @vector_new(i64 2)
  %heap_start9 = sub i64 %15, 2
  %heap_to_ptr10 = inttoptr i64 %heap_start9 to ptr
  %struct_member = getelementptr inbounds { i64, ptr }, ptr %heap_to_ptr10, i32 0, i32 0
  store i64 20, ptr %struct_member, align 4
  %struct_member11 = getelementptr inbounds { i64, ptr }, ptr %heap_to_ptr10, i32 0, i32 1
  store ptr %heap_to_ptr, ptr %struct_member11, align 8
  ret ptr %heap_to_ptr10
}

define i64 @getFirstGrade(ptr %0) {
entry:
  %_student = alloca ptr, align 8
  store ptr %0, ptr %_student, align 8
  %1 = load ptr, ptr %_student, align 8
  %struct_member = getelementptr { i64, ptr }, ptr %1, i64 1
  %2 = load ptr, ptr %struct_member, align 8
  %length = load i64, ptr %2, align 4
  %3 = sub i64 %length, 1
  %4 = sub i64 %3, 0
  call void @builtin_range_check(i64 %4)
  %5 = ptrtoint ptr %2 to i64
  %6 = add i64 %5, 1
  %vector_data = inttoptr i64 %6 to ptr
  %index_access = getelementptr i64, ptr %vector_data, i64 0
  %7 = load i64, ptr %index_access, align 4
  ret i64 %7
}

define void @function_dispatch(i64 %0, i64 %1, ptr %2) {
entry:
  %offset_ptr = alloca i64, align 8
  %index_ptr = alloca i64, align 8
  %input_alloca = alloca ptr, align 8
  store ptr %2, ptr %input_alloca, align 8
  %input = load ptr, ptr %input_alloca, align 8
  switch i64 %0, label %missing_function [
    i64 15777857, label %func_0_dispatch
    i64 3386949871, label %func_1_dispatch
  ]

missing_function:                                 ; preds = %entry
  unreachable

func_0_dispatch:                                  ; preds = %entry
  %3 = call ptr @createStudent()
  %struct_start = ptrtoint ptr %3 to i64
  %4 = add i64 %struct_start, 1
  %5 = inttoptr i64 %4 to ptr
  %length = load i64, ptr %5, align 4
  %6 = mul i64 %length, 1
  %7 = add i64 %6, 1
  %8 = add i64 %4, %7
  %9 = inttoptr i64 %8 to ptr
  %10 = sub i64 %8, %struct_start
  %heap_size = add i64 %10, 1
  %11 = call i64 @vector_new(i64 %heap_size)
  %heap_start = sub i64 %11, %heap_size
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %struct_member = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 0
  %elem = load i64, ptr %struct_member, align 4
  %encode_value_ptr = getelementptr i64, ptr %heap_to_ptr, i64 0
  store i64 %elem, ptr %encode_value_ptr, align 4
  %struct_member1 = getelementptr inbounds { i64, ptr }, ptr %3, i32 0, i32 1
  %length2 = load i64, ptr %struct_member1, align 4
  %encode_value_ptr3 = getelementptr i64, ptr %heap_to_ptr, i64 1
  store i64 %length2, ptr %encode_value_ptr3, align 4
  store i64 2, ptr %offset_ptr, align 4
  store i64 0, ptr %index_ptr, align 4
  br label %loop_body

loop_body:                                        ; preds = %loop_body, %func_0_dispatch
  %index = load i64, ptr %index_ptr, align 4
  %element = getelementptr ptr, ptr %struct_member1, i64 %index
  %elem4 = load i64, ptr %element, align 4
  %offset = load i64, ptr %offset_ptr, align 4
  %encode_value_ptr5 = getelementptr i64, ptr %heap_to_ptr, i64 %offset
  store i64 %elem4, ptr %encode_value_ptr5, align 4
  %next_offset = add i64 1, %offset
  store i64 %next_offset, ptr %offset_ptr, align 4
  %next_index = add i64 %index, 1
  store i64 %next_index, ptr %index_ptr, align 4
  %index_cond = icmp ult i64 %next_index, %length2
  br i1 %index_cond, label %loop_body, label %loop_end

loop_end:                                         ; preds = %loop_body
  %12 = add i64 %length2, 1
  %13 = add i64 %12, 1
  %encode_value_ptr6 = getelementptr i64, ptr %heap_to_ptr, i64 %13
  store i64 %10, ptr %encode_value_ptr6, align 4
  call void @set_tape_data(i64 %heap_start, i64 %heap_size)
  ret void

func_1_dispatch:                                  ; preds = %entry
  %input_start = ptrtoint ptr %input to i64
  %14 = inttoptr i64 %input_start to ptr
  %decode_value = load i64, ptr %14, align 4
  %struct_offset = add i64 %input_start, 1
  %15 = inttoptr i64 %struct_offset to ptr
  %length7 = load i64, ptr %15, align 4
  %16 = mul i64 %length7, 1
  %17 = add i64 %16, 1
  %struct_offset8 = add i64 %struct_offset, %17
  %struct_decode_size = sub i64 %struct_offset8, %input_start
  %18 = call i64 @vector_new(i64 2)
  %heap_start9 = sub i64 %18, 2
  %heap_to_ptr10 = inttoptr i64 %heap_start9 to ptr
  %struct_member11 = getelementptr { i64, ptr }, ptr %heap_to_ptr10, i64 0
  store i64 %decode_value, ptr %struct_member11, align 4
  %struct_member12 = getelementptr { i64, ptr }, ptr %heap_to_ptr10, i64 1
  store ptr %15, ptr %struct_member12, align 8
  %19 = call i64 @getFirstGrade(ptr %heap_to_ptr10)
  %20 = call i64 @vector_new(i64 2)
  %heap_start13 = sub i64 %20, 2
  %heap_to_ptr14 = inttoptr i64 %heap_start13 to ptr
  %encode_value_ptr15 = getelementptr i64, ptr %heap_to_ptr14, i64 0
  store i64 %19, ptr %encode_value_ptr15, align 4
  %encode_value_ptr16 = getelementptr i64, ptr %heap_to_ptr14, i64 1
  store i64 1, ptr %encode_value_ptr16, align 4
  call void @set_tape_data(i64 %heap_start13, i64 2)
  ret void
}

define void @main() {
entry:
  %0 = call i64 @vector_new(i64 13)
  %heap_start = sub i64 %0, 13
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  call void @get_tape_data(i64 %heap_start, i64 13)
  %function_selector = load i64, ptr %heap_to_ptr, align 4
  %1 = call i64 @vector_new(i64 14)
  %heap_start1 = sub i64 %1, 14
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  call void @get_tape_data(i64 %heap_start1, i64 14)
  %input_length = load i64, ptr %heap_to_ptr2, align 4
  %2 = add i64 %input_length, 14
  %3 = call i64 @vector_new(i64 %2)
  %heap_start3 = sub i64 %3, %2
  %heap_to_ptr4 = inttoptr i64 %heap_start3 to ptr
  call void @get_tape_data(i64 %heap_start3, i64 %2)
  call void @function_dispatch(i64 %function_selector, i64 %input_length, ptr %heap_to_ptr4)
  ret void
}
