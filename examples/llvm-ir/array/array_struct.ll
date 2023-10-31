; ModuleID = 'StructArrayExample'
source_filename = "examples/source/array/array_struct.ola"

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

define ptr @createBooks() {
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
  %loop_cond = icmp ult i64 %index_value, 1
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %index_access = getelementptr { i64, i64 }, ptr %vector_data, i64 %index_value
  %3 = call i64 @vector_new(i64 2)
  %heap_start1 = sub i64 %3, 2
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  store ptr %heap_to_ptr2, ptr %index_access, align 8
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  %length = load i64, ptr %heap_to_ptr, align 4
  %4 = sub i64 %length, 1
  %5 = sub i64 %4, 0
  call void @builtin_range_check(i64 %5)
  %6 = ptrtoint ptr %heap_to_ptr to i64
  %7 = add i64 %6, 1
  %vector_data3 = inttoptr i64 %7 to ptr
  %index_access4 = getelementptr ptr, ptr %vector_data3, i64 0
  %8 = call i64 @vector_new(i64 2)
  %heap_start5 = sub i64 %8, 2
  %heap_to_ptr6 = inttoptr i64 %heap_start5 to ptr
  %struct_member = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr6, i32 0, i32 0
  store i64 99, ptr %struct_member, align 4
  %struct_member7 = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr6, i32 0, i32 1
  store i64 100, ptr %struct_member7, align 4
  %9 = load { i64, i64 }, ptr %heap_to_ptr6, align 4
  store { i64, i64 } %9, ptr %index_access4, align 4
  ret ptr %heap_to_ptr
}

define void @function_dispatch(i64 %0, i64 %1, ptr %2) {
entry:
  %offset_ptr = alloca i64, align 8
  %index_ptr = alloca i64, align 8
  %input_alloca = alloca ptr, align 8
  store ptr %2, ptr %input_alloca, align 8
  %input = load ptr, ptr %input_alloca, align 8
  switch i64 %0, label %missing_function [
    i64 2736305406, label %func_0_dispatch
  ]

missing_function:                                 ; preds = %entry
  unreachable

func_0_dispatch:                                  ; preds = %entry
  %3 = call ptr @createBooks()
  %length = load i64, ptr %3, align 4
  %4 = mul i64 %length, 2
  %5 = add i64 %4, 1
  %heap_size = add i64 %5, 1
  %6 = call i64 @vector_new(i64 %heap_size)
  %heap_start = sub i64 %6, %heap_size
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %length1 = load i64, ptr %3, align 4
  %encode_value_ptr = getelementptr i64, ptr %heap_to_ptr, i64 0
  store i64 %length1, ptr %encode_value_ptr, align 4
  store i64 1, ptr %offset_ptr, align 4
  store i64 0, ptr %index_ptr, align 4
  br label %loop_body

loop_body:                                        ; preds = %loop_body, %func_0_dispatch
  %index = load i64, ptr %index_ptr, align 4
  %element = getelementptr ptr, ptr %3, i64 %index
  %offset = load i64, ptr %offset_ptr, align 4
  %struct_member = getelementptr inbounds { i64, i64 }, ptr %element, i32 0, i32 0
  %elem = load i64, ptr %struct_member, align 4
  %encode_value_ptr2 = getelementptr i64, ptr %heap_to_ptr, i64 %offset
  store i64 %elem, ptr %encode_value_ptr2, align 4
  %7 = add i64 1, %offset
  %struct_member3 = getelementptr inbounds { i64, i64 }, ptr %element, i32 0, i32 1
  %elem4 = load i64, ptr %struct_member3, align 4
  %encode_value_ptr5 = getelementptr i64, ptr %heap_to_ptr, i64 %7
  store i64 %elem4, ptr %encode_value_ptr5, align 4
  %next_offset = add i64 2, %offset
  store i64 %next_offset, ptr %offset_ptr, align 4
  %next_index = add i64 %index, 1
  store i64 %next_index, ptr %index_ptr, align 4
  %index_cond = icmp ult i64 %next_index, %length1
  br i1 %index_cond, label %loop_body, label %loop_end

loop_end:                                         ; preds = %loop_body
  %8 = add i64 %length1, 1
  %encode_value_ptr6 = getelementptr i64, ptr %heap_to_ptr, i64 %8
  store i64 %5, ptr %encode_value_ptr6, align 4
  call void @set_tape_data(i64 %heap_start, i64 %heap_size)
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
