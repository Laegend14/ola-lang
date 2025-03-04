; ModuleID = 'ProposalContract'
source_filename = "proposal"

@heap_address = internal global i64 -12884901885

declare void @builtin_assert(i64)

declare void @builtin_range_check(i64)

declare i64 @builtin_check_ecdsa(ptr)

declare i64 @prophet_u32_sqrt(i64)

declare i64 @prophet_u32_div(i64, i64)

declare i64 @prophet_u32_mod(i64, i64)

declare ptr @prophet_u32_array_sort(ptr, i64)

declare i64 @prophet_split_field_high(i64)

declare i64 @prophet_split_field_low(i64)

declare void @get_context_data(ptr, i64)

declare void @get_tape_data(ptr, i64)

declare void @set_tape_data(ptr, i64)

declare void @get_storage(ptr, ptr)

declare void @set_storage(ptr, ptr)

declare void @poseidon_hash(ptr, ptr, i64)

declare void @contract_call(ptr, i64)

declare void @prophet_printf(i64, i64)

define ptr @heap_malloc(i64 %0) {
entry:
  %current_address = load i64, ptr @heap_address, align 4
  %updated_address = add i64 %current_address, %0
  store i64 %updated_address, ptr @heap_address, align 4
  %1 = inttoptr i64 %current_address to ptr
  ret ptr %1
}

define ptr @vector_new(i64 %0) {
entry:
  %1 = add i64 %0, 1
  %current_address = load i64, ptr @heap_address, align 4
  %updated_address = add i64 %current_address, %1
  store i64 %updated_address, ptr @heap_address, align 4
  %2 = inttoptr i64 %current_address to ptr
  store i64 %0, ptr %2, align 4
  ret ptr %2
}

define void @split_field(i64 %0, ptr %1, ptr %2) {
entry:
  %3 = call i64 @prophet_split_field_high(i64 %0)
  call void @builtin_range_check(i64 %3)
  %4 = call i64 @prophet_split_field_low(i64 %0)
  call void @builtin_range_check(i64 %4)
  %5 = mul i64 %3, 4294967296
  %6 = add i64 %5, %4
  %7 = icmp eq i64 %0, %6
  %8 = zext i1 %7 to i64
  call void @builtin_assert(i64 %8)
  store i64 %3, ptr %1, align 4
  store i64 %4, ptr %2, align 4
  ret void
}

define void @memcpy(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, %2
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %src_index_access = getelementptr i64, ptr %0, i64 %index_value
  %3 = load i64, ptr %src_index_access, align 4
  %dest_index_access = getelementptr i64, ptr %1, i64 %index_value
  store i64 %3, ptr %dest_index_access, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  ret void
}

define i64 @memcmp_eq(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp eq i64 %left_elem, %right_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %cond ], [ 0, %body ]
  ret i64 %result_phi
}

define i64 @memcmp_ne(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp eq i64 %left_elem, %right_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %body ], [ 0, %cond ]
  ret i64 %result_phi
}

define i64 @memcmp_ugt(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp uge i64 %right_elem, %left_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %body ], [ 0, %cond ]
  ret i64 %result_phi
}

define i64 @memcmp_uge(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp uge i64 %left_elem, %right_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %cond ], [ 0, %body ]
  ret i64 %result_phi
}

define i64 @memcmp_ult(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp uge i64 %left_elem, %right_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %body ], [ 0, %cond ]
  ret i64 %result_phi
}

define i64 @memcmp_ule(ptr %0, ptr %1, i64 %2) {
entry:
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare = icmp uge i64 %right_elem, %left_elem
  br i1 %compare, label %cond, label %done

done:                                             ; preds = %body, %cond
  %result_phi = phi i64 [ 1, %cond ], [ 0, %body ]
  ret i64 %result_phi
}

define i64 @field_memcmp_ugt(ptr %0, ptr %1, i64 %2) {
entry:
  %right_low = alloca i64, align 8
  %right_high = alloca i64, align 8
  %left_low = alloca i64, align 8
  %left_high = alloca i64, align 8
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %low_compare_block, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  call void @split_field(i64 %left_elem, ptr %left_high, ptr %left_low)
  %3 = load i64, ptr %left_high, align 4
  %4 = load i64, ptr %left_low, align 4
  call void @split_field(i64 %right_elem, ptr %right_high, ptr %right_low)
  %5 = load i64, ptr %right_high, align 4
  %6 = load i64, ptr %right_low, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare_high = icmp uge i64 %5, %3
  br i1 %compare_high, label %low_compare_block, label %done

low_compare_block:                                ; preds = %body
  %compare_low = icmp uge i64 %6, %4
  br i1 %compare_low, label %cond, label %done

done:                                             ; preds = %low_compare_block, %body, %cond
  %result_phi = phi i64 [ 1, %body ], [ 1, %low_compare_block ], [ 0, %cond ]
  ret i64 %result_phi
}

define i64 @field_memcmp_uge(ptr %0, ptr %1, i64 %2) {
entry:
  %right_low = alloca i64, align 8
  %right_high = alloca i64, align 8
  %left_low = alloca i64, align 8
  %left_high = alloca i64, align 8
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %low_compare_block, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  call void @split_field(i64 %left_elem, ptr %left_high, ptr %left_low)
  %3 = load i64, ptr %left_high, align 4
  %4 = load i64, ptr %left_low, align 4
  call void @split_field(i64 %right_elem, ptr %right_high, ptr %right_low)
  %5 = load i64, ptr %right_high, align 4
  %6 = load i64, ptr %right_low, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare_high = icmp uge i64 %3, %5
  br i1 %compare_high, label %low_compare_block, label %done

low_compare_block:                                ; preds = %body
  %compare_low = icmp uge i64 %4, %6
  br i1 %compare_low, label %cond, label %done

done:                                             ; preds = %low_compare_block, %body, %cond
  %result_phi = phi i64 [ 1, %cond ], [ 0, %body ], [ 0, %low_compare_block ]
  ret i64 %result_phi
}

define i64 @field_memcmp_ule(ptr %0, ptr %1, i64 %2) {
entry:
  %right_low = alloca i64, align 8
  %right_high = alloca i64, align 8
  %left_low = alloca i64, align 8
  %left_high = alloca i64, align 8
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %low_compare_block, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  call void @split_field(i64 %left_elem, ptr %left_high, ptr %left_low)
  %3 = load i64, ptr %left_high, align 4
  %4 = load i64, ptr %left_low, align 4
  call void @split_field(i64 %right_elem, ptr %right_high, ptr %right_low)
  %5 = load i64, ptr %right_high, align 4
  %6 = load i64, ptr %right_low, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare_high = icmp uge i64 %5, %3
  br i1 %compare_high, label %low_compare_block, label %done

low_compare_block:                                ; preds = %body
  %compare_low = icmp uge i64 %6, %4
  br i1 %compare_low, label %cond, label %done

done:                                             ; preds = %low_compare_block, %body, %cond
  %result_phi = phi i64 [ 1, %cond ], [ 0, %body ], [ 0, %low_compare_block ]
  ret i64 %result_phi
}

define i64 @field_memcmp_ult(ptr %0, ptr %1, i64 %2) {
entry:
  %right_low = alloca i64, align 8
  %right_high = alloca i64, align 8
  %left_low = alloca i64, align 8
  %left_high = alloca i64, align 8
  %index_alloca = alloca i64, align 8
  store i64 0, ptr %index_alloca, align 4
  br label %cond

cond:                                             ; preds = %low_compare_block, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_check = icmp ult i64 %index_value, %2
  br i1 %loop_check, label %body, label %done

body:                                             ; preds = %cond
  %left_elem_ptr = getelementptr i64, ptr %0, i64 %index_value
  %left_elem = load i64, ptr %left_elem_ptr, align 4
  %right_elem_ptr = getelementptr i64, ptr %1, i64 %index_value
  %right_elem = load i64, ptr %right_elem_ptr, align 4
  call void @split_field(i64 %left_elem, ptr %left_high, ptr %left_low)
  %3 = load i64, ptr %left_high, align 4
  %4 = load i64, ptr %left_low, align 4
  call void @split_field(i64 %right_elem, ptr %right_high, ptr %right_low)
  %5 = load i64, ptr %right_high, align 4
  %6 = load i64, ptr %right_low, align 4
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  %compare_high = icmp uge i64 %3, %5
  br i1 %compare_high, label %low_compare_block, label %done

low_compare_block:                                ; preds = %body
  %compare_low = icmp uge i64 %4, %6
  br i1 %compare_low, label %cond, label %done

done:                                             ; preds = %low_compare_block, %body, %cond
  %result_phi = phi i64 [ 1, %body ], [ 1, %low_compare_block ], [ 0, %cond ]
  ret i64 %result_phi
}

define void @u32_div_mod(i64 %0, i64 %1, ptr %2, ptr %3) {
entry:
  %4 = call i64 @prophet_u32_mod(i64 %0, i64 %1)
  call void @builtin_range_check(i64 %4)
  %5 = add i64 %4, 1
  %6 = sub i64 %1, %5
  call void @builtin_range_check(i64 %6)
  %7 = call i64 @prophet_u32_div(i64 %0, i64 %1)
  call void @builtin_range_check(ptr %2)
  %8 = mul i64 %7, %1
  %9 = add i64 %8, %4
  %10 = icmp eq i64 %9, %0
  %11 = zext i1 %10 to i64
  call void @builtin_assert(i64 %11)
  store i64 %7, ptr %2, align 4
  store i64 %4, ptr %3, align 4
  ret void
}

define i64 @u32_power(i64 %0, i64 %1) {
entry:
  br label %loop

loop:                                             ; preds = %loop, %entry
  %2 = phi i64 [ 0, %entry ], [ %inc, %loop ]
  %3 = phi i64 [ 1, %entry ], [ %multmp, %loop ]
  %inc = add i64 %2, 1
  %multmp = mul i64 %3, %0
  %loopcond = icmp ule i64 %inc, %1
  br i1 %loopcond, label %loop, label %exit

exit:                                             ; preds = %loop
  call void @builtin_range_check(i64 %3)
  ret i64 %3
}

define void @createProposal(ptr %0, i64 %1, i64 %2, i64 %3) {
entry:
  %_proposalType = alloca i64, align 8
  %_votingType = alloca i64, align 8
  %_deadline = alloca i64, align 8
  %_contentHash = alloca ptr, align 8
  store ptr %0, ptr %_contentHash, align 8
  store i64 %1, ptr %_deadline, align 4
  store i64 %2, ptr %_votingType, align 4
  store i64 %3, ptr %_proposalType, align 4
  %4 = load i64, ptr %_deadline, align 4
  %5 = call ptr @heap_malloc(i64 1)
  call void @get_context_data(ptr %5, i64 1)
  %6 = load i64, ptr %5, align 4
  %7 = icmp ugt i64 %4, %6
  %8 = zext i1 %7 to i64
  call void @builtin_assert(i64 %8)
  %9 = load ptr, ptr %_contentHash, align 8
  %10 = call ptr @heap_malloc(i64 4)
  %11 = getelementptr i64, ptr %10, i64 0
  store i64 0, ptr %11, align 4
  %12 = getelementptr i64, ptr %10, i64 1
  store i64 0, ptr %12, align 4
  %13 = getelementptr i64, ptr %10, i64 2
  store i64 0, ptr %13, align 4
  %14 = getelementptr i64, ptr %10, i64 3
  store i64 0, ptr %14, align 4
  %15 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %10, ptr %15, i64 4)
  %16 = getelementptr i64, ptr %15, i64 4
  call void @memcpy(ptr %9, ptr %16, i64 4)
  %17 = getelementptr i64, ptr %16, i64 4
  %18 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %15, ptr %18, i64 8)
  %19 = call ptr @heap_malloc(i64 6)
  %20 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %20)
  %21 = getelementptr i64, ptr %18, i64 3
  %22 = load i64, ptr %21, align 4
  %slot_offset = add i64 %22, 1
  store i64 %slot_offset, ptr %21, align 4
  %proposer = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 0
  store ptr %20, ptr %proposer, align 8
  %23 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %23)
  %24 = getelementptr i64, ptr %23, i64 3
  %storage_value = load i64, ptr %24, align 4
  %25 = getelementptr i64, ptr %18, i64 3
  %26 = load i64, ptr %25, align 4
  %slot_offset1 = add i64 %26, 1
  store i64 %slot_offset1, ptr %25, align 4
  %deadline = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 1
  store i64 %storage_value, ptr %deadline, align 4
  %27 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %27)
  %28 = getelementptr i64, ptr %27, i64 3
  %storage_value2 = load i64, ptr %28, align 4
  %29 = getelementptr i64, ptr %18, i64 3
  %30 = load i64, ptr %29, align 4
  %slot_offset3 = add i64 %30, 1
  store i64 %slot_offset3, ptr %29, align 4
  %totalSupport = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 2
  store i64 %storage_value2, ptr %totalSupport, align 4
  %31 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %31)
  %32 = getelementptr i64, ptr %31, i64 3
  %storage_value4 = load i64, ptr %32, align 4
  %33 = getelementptr i64, ptr %18, i64 3
  %34 = load i64, ptr %33, align 4
  %slot_offset5 = add i64 %34, 1
  store i64 %slot_offset5, ptr %33, align 4
  %totalAgainst = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 3
  store i64 %storage_value4, ptr %totalAgainst, align 4
  %35 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %35)
  %36 = getelementptr i64, ptr %35, i64 3
  %storage_value6 = load i64, ptr %36, align 4
  %37 = getelementptr i64, ptr %18, i64 3
  %38 = load i64, ptr %37, align 4
  %slot_offset7 = add i64 %38, 1
  store i64 %slot_offset7, ptr %37, align 4
  %votingType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 4
  store i64 %storage_value6, ptr %votingType, align 4
  %39 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %18, ptr %39)
  %40 = getelementptr i64, ptr %39, i64 3
  %storage_value8 = load i64, ptr %40, align 4
  %41 = getelementptr i64, ptr %18, i64 3
  %42 = load i64, ptr %41, align 4
  %slot_offset9 = add i64 %42, 1
  store i64 %slot_offset9, ptr %41, align 4
  %proposalType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 5
  store i64 %storage_value8, ptr %proposalType, align 4
  %struct_member = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %19, i32 0, i32 0
  %43 = load ptr, ptr %struct_member, align 8
  %44 = call ptr @heap_malloc(i64 4)
  %index_access = getelementptr i64, ptr %44, i64 0
  store i64 0, ptr %index_access, align 4
  %index_access10 = getelementptr i64, ptr %44, i64 1
  store i64 0, ptr %index_access10, align 4
  %index_access11 = getelementptr i64, ptr %44, i64 2
  store i64 0, ptr %index_access11, align 4
  %index_access12 = getelementptr i64, ptr %44, i64 3
  store i64 0, ptr %index_access12, align 4
  %45 = call i64 @memcmp_eq(ptr %43, ptr %44, i64 4)
  call void @builtin_assert(i64 %45)
  %46 = call ptr @heap_malloc(i64 6)
  %struct_member13 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 0
  %47 = call ptr @heap_malloc(i64 4)
  %48 = getelementptr i64, ptr %47, i64 0
  call void @get_context_data(ptr %48, i64 8)
  %49 = getelementptr i64, ptr %47, i64 1
  call void @get_context_data(ptr %49, i64 9)
  %50 = getelementptr i64, ptr %47, i64 2
  call void @get_context_data(ptr %50, i64 10)
  %51 = getelementptr i64, ptr %47, i64 3
  call void @get_context_data(ptr %51, i64 11)
  store ptr %47, ptr %struct_member13, align 8
  %struct_member14 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 1
  %52 = load i64, ptr %_deadline, align 4
  store i64 %52, ptr %struct_member14, align 4
  %struct_member15 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 2
  store i64 0, ptr %struct_member15, align 4
  %struct_member16 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 3
  store i64 0, ptr %struct_member16, align 4
  %struct_member17 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 4
  %53 = load i64, ptr %_votingType, align 4
  store i64 %53, ptr %struct_member17, align 4
  %struct_member18 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 5
  %54 = load i64, ptr %_proposalType, align 4
  store i64 %54, ptr %struct_member18, align 4
  %55 = load ptr, ptr %_contentHash, align 8
  %56 = call ptr @heap_malloc(i64 4)
  %57 = getelementptr i64, ptr %56, i64 0
  store i64 0, ptr %57, align 4
  %58 = getelementptr i64, ptr %56, i64 1
  store i64 0, ptr %58, align 4
  %59 = getelementptr i64, ptr %56, i64 2
  store i64 0, ptr %59, align 4
  %60 = getelementptr i64, ptr %56, i64 3
  store i64 0, ptr %60, align 4
  %61 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %56, ptr %61, i64 4)
  %62 = getelementptr i64, ptr %61, i64 4
  call void @memcpy(ptr %55, ptr %62, i64 4)
  %63 = getelementptr i64, ptr %62, i64 4
  %64 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %61, ptr %64, i64 8)
  %proposer19 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 0
  %65 = load ptr, ptr %proposer19, align 8
  call void @set_storage(ptr %64, ptr %65)
  %66 = getelementptr i64, ptr %64, i64 3
  %67 = load i64, ptr %66, align 4
  %slot_offset20 = add i64 %67, 1
  store i64 %slot_offset20, ptr %66, align 4
  %deadline21 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 1
  %68 = load i64, ptr %deadline21, align 4
  %69 = call ptr @heap_malloc(i64 4)
  %70 = getelementptr i64, ptr %69, i64 0
  store i64 0, ptr %70, align 4
  %71 = getelementptr i64, ptr %69, i64 1
  store i64 0, ptr %71, align 4
  %72 = getelementptr i64, ptr %69, i64 2
  store i64 0, ptr %72, align 4
  %73 = getelementptr i64, ptr %69, i64 3
  store i64 %68, ptr %73, align 4
  call void @set_storage(ptr %64, ptr %69)
  %74 = getelementptr i64, ptr %64, i64 3
  %75 = load i64, ptr %74, align 4
  %slot_offset22 = add i64 %75, 1
  store i64 %slot_offset22, ptr %74, align 4
  %totalSupport23 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 2
  %76 = load i64, ptr %totalSupport23, align 4
  %77 = call ptr @heap_malloc(i64 4)
  %78 = getelementptr i64, ptr %77, i64 0
  store i64 0, ptr %78, align 4
  %79 = getelementptr i64, ptr %77, i64 1
  store i64 0, ptr %79, align 4
  %80 = getelementptr i64, ptr %77, i64 2
  store i64 0, ptr %80, align 4
  %81 = getelementptr i64, ptr %77, i64 3
  store i64 %76, ptr %81, align 4
  call void @set_storage(ptr %64, ptr %77)
  %82 = getelementptr i64, ptr %64, i64 3
  %83 = load i64, ptr %82, align 4
  %slot_offset24 = add i64 %83, 1
  store i64 %slot_offset24, ptr %82, align 4
  %totalAgainst25 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 3
  %84 = load i64, ptr %totalAgainst25, align 4
  %85 = call ptr @heap_malloc(i64 4)
  %86 = getelementptr i64, ptr %85, i64 0
  store i64 0, ptr %86, align 4
  %87 = getelementptr i64, ptr %85, i64 1
  store i64 0, ptr %87, align 4
  %88 = getelementptr i64, ptr %85, i64 2
  store i64 0, ptr %88, align 4
  %89 = getelementptr i64, ptr %85, i64 3
  store i64 %84, ptr %89, align 4
  call void @set_storage(ptr %64, ptr %85)
  %90 = getelementptr i64, ptr %64, i64 3
  %91 = load i64, ptr %90, align 4
  %slot_offset26 = add i64 %91, 1
  store i64 %slot_offset26, ptr %90, align 4
  %votingType27 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 4
  %92 = load i64, ptr %votingType27, align 4
  %93 = call ptr @heap_malloc(i64 4)
  %94 = getelementptr i64, ptr %93, i64 0
  store i64 0, ptr %94, align 4
  %95 = getelementptr i64, ptr %93, i64 1
  store i64 0, ptr %95, align 4
  %96 = getelementptr i64, ptr %93, i64 2
  store i64 0, ptr %96, align 4
  %97 = getelementptr i64, ptr %93, i64 3
  store i64 %92, ptr %97, align 4
  call void @set_storage(ptr %64, ptr %93)
  %98 = getelementptr i64, ptr %64, i64 3
  %99 = load i64, ptr %98, align 4
  %slot_offset28 = add i64 %99, 1
  store i64 %slot_offset28, ptr %98, align 4
  %proposalType29 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %46, i32 0, i32 5
  %100 = load i64, ptr %proposalType29, align 4
  %101 = call ptr @heap_malloc(i64 4)
  %102 = getelementptr i64, ptr %101, i64 0
  store i64 0, ptr %102, align 4
  %103 = getelementptr i64, ptr %101, i64 1
  store i64 0, ptr %103, align 4
  %104 = getelementptr i64, ptr %101, i64 2
  store i64 0, ptr %104, align 4
  %105 = getelementptr i64, ptr %101, i64 3
  store i64 %100, ptr %105, align 4
  call void @set_storage(ptr %64, ptr %101)
  %106 = call ptr @heap_malloc(i64 4)
  %107 = getelementptr i64, ptr %106, i64 0
  call void @get_context_data(ptr %107, i64 8)
  %108 = getelementptr i64, ptr %106, i64 1
  call void @get_context_data(ptr %108, i64 9)
  %109 = getelementptr i64, ptr %106, i64 2
  call void @get_context_data(ptr %109, i64 10)
  %110 = getelementptr i64, ptr %106, i64 3
  call void @get_context_data(ptr %110, i64 11)
  %111 = call ptr @heap_malloc(i64 4)
  %112 = getelementptr i64, ptr %111, i64 0
  store i64 0, ptr %112, align 4
  %113 = getelementptr i64, ptr %111, i64 1
  store i64 0, ptr %113, align 4
  %114 = getelementptr i64, ptr %111, i64 2
  store i64 0, ptr %114, align 4
  %115 = getelementptr i64, ptr %111, i64 3
  store i64 1, ptr %115, align 4
  %116 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %111, ptr %116, i64 4)
  %117 = getelementptr i64, ptr %116, i64 4
  call void @memcpy(ptr %106, ptr %117, i64 4)
  %118 = getelementptr i64, ptr %117, i64 4
  %119 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %116, ptr %119, i64 8)
  %120 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %119, ptr %120)
  %length = getelementptr i64, ptr %120, i64 3
  %121 = load i64, ptr %length, align 4
  %122 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %119, ptr %122, i64 4)
  %hash_value_low = getelementptr i64, ptr %122, i64 3
  %123 = load i64, ptr %hash_value_low, align 4
  %124 = mul i64 %121, 1
  %storage_array_offset = add i64 %123, %124
  store i64 %storage_array_offset, ptr %hash_value_low, align 4
  %125 = load ptr, ptr %_contentHash, align 8
  call void @set_storage(ptr %122, ptr %125)
  %new_length = add i64 %121, 1
  %126 = call ptr @heap_malloc(i64 4)
  %127 = getelementptr i64, ptr %126, i64 0
  store i64 0, ptr %127, align 4
  %128 = getelementptr i64, ptr %126, i64 1
  store i64 0, ptr %128, align 4
  %129 = getelementptr i64, ptr %126, i64 2
  store i64 0, ptr %129, align 4
  %130 = getelementptr i64, ptr %126, i64 3
  store i64 %new_length, ptr %130, align 4
  call void @set_storage(ptr %119, ptr %126)
  ret void
}

define void @vote(ptr %0, i64 %1, i64 %2) {
entry:
  %i = alloca i64, align 8
  %3 = alloca ptr, align 8
  %index_alloca = alloca i64, align 8
  %_weight = alloca i64, align 8
  %_support = alloca i64, align 8
  %_contentHash = alloca ptr, align 8
  store ptr %0, ptr %_contentHash, align 8
  store i64 %1, ptr %_support, align 4
  store i64 %2, ptr %_weight, align 4
  %4 = load ptr, ptr %_contentHash, align 8
  %5 = call ptr @heap_malloc(i64 4)
  %6 = getelementptr i64, ptr %5, i64 0
  store i64 0, ptr %6, align 4
  %7 = getelementptr i64, ptr %5, i64 1
  store i64 0, ptr %7, align 4
  %8 = getelementptr i64, ptr %5, i64 2
  store i64 0, ptr %8, align 4
  %9 = getelementptr i64, ptr %5, i64 3
  store i64 0, ptr %9, align 4
  %10 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %5, ptr %10, i64 4)
  %11 = getelementptr i64, ptr %10, i64 4
  call void @memcpy(ptr %4, ptr %11, i64 4)
  %12 = getelementptr i64, ptr %11, i64 4
  %13 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %10, ptr %13, i64 8)
  %14 = call ptr @heap_malloc(i64 6)
  %15 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %15)
  %16 = getelementptr i64, ptr %13, i64 3
  %17 = load i64, ptr %16, align 4
  %slot_offset = add i64 %17, 1
  store i64 %slot_offset, ptr %16, align 4
  %proposer = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 0
  store ptr %15, ptr %proposer, align 8
  %18 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %18)
  %19 = getelementptr i64, ptr %18, i64 3
  %storage_value = load i64, ptr %19, align 4
  %20 = getelementptr i64, ptr %13, i64 3
  %21 = load i64, ptr %20, align 4
  %slot_offset1 = add i64 %21, 1
  store i64 %slot_offset1, ptr %20, align 4
  %deadline = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 1
  store i64 %storage_value, ptr %deadline, align 4
  %22 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %22)
  %23 = getelementptr i64, ptr %22, i64 3
  %storage_value2 = load i64, ptr %23, align 4
  %24 = getelementptr i64, ptr %13, i64 3
  %25 = load i64, ptr %24, align 4
  %slot_offset3 = add i64 %25, 1
  store i64 %slot_offset3, ptr %24, align 4
  %totalSupport = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 2
  store i64 %storage_value2, ptr %totalSupport, align 4
  %26 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %26)
  %27 = getelementptr i64, ptr %26, i64 3
  %storage_value4 = load i64, ptr %27, align 4
  %28 = getelementptr i64, ptr %13, i64 3
  %29 = load i64, ptr %28, align 4
  %slot_offset5 = add i64 %29, 1
  store i64 %slot_offset5, ptr %28, align 4
  %totalAgainst = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 3
  store i64 %storage_value4, ptr %totalAgainst, align 4
  %30 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %30)
  %31 = getelementptr i64, ptr %30, i64 3
  %storage_value6 = load i64, ptr %31, align 4
  %32 = getelementptr i64, ptr %13, i64 3
  %33 = load i64, ptr %32, align 4
  %slot_offset7 = add i64 %33, 1
  store i64 %slot_offset7, ptr %32, align 4
  %votingType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 4
  store i64 %storage_value6, ptr %votingType, align 4
  %34 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %13, ptr %34)
  %35 = getelementptr i64, ptr %34, i64 3
  %storage_value8 = load i64, ptr %35, align 4
  %36 = getelementptr i64, ptr %13, i64 3
  %37 = load i64, ptr %36, align 4
  %slot_offset9 = add i64 %37, 1
  store i64 %slot_offset9, ptr %36, align 4
  %proposalType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 5
  store i64 %storage_value8, ptr %proposalType, align 4
  %struct_member = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %14, i32 0, i32 0
  %38 = load ptr, ptr %struct_member, align 8
  %39 = call ptr @heap_malloc(i64 4)
  %index_access = getelementptr i64, ptr %39, i64 0
  store i64 0, ptr %index_access, align 4
  %index_access10 = getelementptr i64, ptr %39, i64 1
  store i64 0, ptr %index_access10, align 4
  %index_access11 = getelementptr i64, ptr %39, i64 2
  store i64 0, ptr %index_access11, align 4
  %index_access12 = getelementptr i64, ptr %39, i64 3
  store i64 0, ptr %index_access12, align 4
  %40 = call i64 @memcmp_ne(ptr %38, ptr %39, i64 4)
  call void @builtin_assert(i64 %40)
  %41 = call ptr @heap_malloc(i64 4)
  %42 = getelementptr i64, ptr %41, i64 0
  call void @get_context_data(ptr %42, i64 8)
  %43 = getelementptr i64, ptr %41, i64 1
  call void @get_context_data(ptr %43, i64 9)
  %44 = getelementptr i64, ptr %41, i64 2
  call void @get_context_data(ptr %44, i64 10)
  %45 = getelementptr i64, ptr %41, i64 3
  call void @get_context_data(ptr %45, i64 11)
  %46 = call ptr @heap_malloc(i64 4)
  %47 = getelementptr i64, ptr %46, i64 0
  store i64 0, ptr %47, align 4
  %48 = getelementptr i64, ptr %46, i64 1
  store i64 0, ptr %48, align 4
  %49 = getelementptr i64, ptr %46, i64 2
  store i64 0, ptr %49, align 4
  %50 = getelementptr i64, ptr %46, i64 3
  store i64 2, ptr %50, align 4
  %51 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %46, ptr %51, i64 4)
  %52 = getelementptr i64, ptr %51, i64 4
  call void @memcpy(ptr %41, ptr %52, i64 4)
  %53 = getelementptr i64, ptr %52, i64 4
  %54 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %51, ptr %54, i64 8)
  %55 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %54, ptr %55)
  %length = getelementptr i64, ptr %55, i64 3
  %56 = load i64, ptr %length, align 4
  %57 = call ptr @vector_new(i64 %56)
  %58 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %54, ptr %58, i64 4)
  store i64 0, ptr %index_alloca, align 4
  store ptr %58, ptr %3, align 8
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, %56
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %59 = load ptr, ptr %3, align 8
  %vector_data = getelementptr i64, ptr %57, i64 1
  %index_access13 = getelementptr ptr, ptr %vector_data, i64 %index_value
  %60 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %59, ptr %60)
  %61 = getelementptr i64, ptr %59, i64 3
  %62 = load i64, ptr %61, align 4
  %slot_offset14 = add i64 %62, 1
  store i64 %slot_offset14, ptr %61, align 4
  store ptr %60, ptr %index_access13, align 8
  store ptr %59, ptr %3, align 8
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  store i64 0, ptr %i, align 4
  br label %cond15

cond15:                                           ; preds = %next, %done
  %63 = load i64, ptr %i, align 4
  %vector_length = load i64, ptr %57, align 4
  %64 = icmp ult i64 %63, %vector_length
  br i1 %64, label %body16, label %endfor

body16:                                           ; preds = %cond15
  %65 = load i64, ptr %i, align 4
  %vector_length17 = load i64, ptr %57, align 4
  %66 = sub i64 %vector_length17, 1
  %67 = sub i64 %66, %65
  call void @builtin_range_check(i64 %67)
  %vector_data18 = getelementptr i64, ptr %57, i64 1
  %index_access19 = getelementptr ptr, ptr %vector_data18, i64 %65
  %68 = load ptr, ptr %index_access19, align 8
  %69 = load ptr, ptr %_contentHash, align 8
  %70 = call i64 @memcmp_ne(ptr %68, ptr %69, i64 4)
  call void @builtin_assert(i64 %70)
  br label %next

next:                                             ; preds = %body16
  %71 = load i64, ptr %i, align 4
  %72 = add i64 %71, 1
  store i64 %72, ptr %i, align 4
  br label %cond15

endfor:                                           ; preds = %cond15
  %73 = load ptr, ptr %_contentHash, align 8
  %74 = call ptr @heap_malloc(i64 4)
  %75 = getelementptr i64, ptr %74, i64 0
  store i64 0, ptr %75, align 4
  %76 = getelementptr i64, ptr %74, i64 1
  store i64 0, ptr %76, align 4
  %77 = getelementptr i64, ptr %74, i64 2
  store i64 0, ptr %77, align 4
  %78 = getelementptr i64, ptr %74, i64 3
  store i64 0, ptr %78, align 4
  %79 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %74, ptr %79, i64 4)
  %80 = getelementptr i64, ptr %79, i64 4
  call void @memcpy(ptr %73, ptr %80, i64 4)
  %81 = getelementptr i64, ptr %80, i64 4
  %82 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %79, ptr %82, i64 8)
  %83 = call ptr @heap_malloc(i64 6)
  %84 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %84)
  %85 = getelementptr i64, ptr %82, i64 3
  %86 = load i64, ptr %85, align 4
  %slot_offset20 = add i64 %86, 1
  store i64 %slot_offset20, ptr %85, align 4
  %proposer21 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 0
  store ptr %84, ptr %proposer21, align 8
  %87 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %87)
  %88 = getelementptr i64, ptr %87, i64 3
  %storage_value22 = load i64, ptr %88, align 4
  %89 = getelementptr i64, ptr %82, i64 3
  %90 = load i64, ptr %89, align 4
  %slot_offset23 = add i64 %90, 1
  store i64 %slot_offset23, ptr %89, align 4
  %deadline24 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 1
  store i64 %storage_value22, ptr %deadline24, align 4
  %91 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %91)
  %92 = getelementptr i64, ptr %91, i64 3
  %storage_value25 = load i64, ptr %92, align 4
  %93 = getelementptr i64, ptr %82, i64 3
  %94 = load i64, ptr %93, align 4
  %slot_offset26 = add i64 %94, 1
  store i64 %slot_offset26, ptr %93, align 4
  %totalSupport27 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 2
  store i64 %storage_value25, ptr %totalSupport27, align 4
  %95 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %95)
  %96 = getelementptr i64, ptr %95, i64 3
  %storage_value28 = load i64, ptr %96, align 4
  %97 = getelementptr i64, ptr %82, i64 3
  %98 = load i64, ptr %97, align 4
  %slot_offset29 = add i64 %98, 1
  store i64 %slot_offset29, ptr %97, align 4
  %totalAgainst30 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 3
  store i64 %storage_value28, ptr %totalAgainst30, align 4
  %99 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %99)
  %100 = getelementptr i64, ptr %99, i64 3
  %storage_value31 = load i64, ptr %100, align 4
  %101 = getelementptr i64, ptr %82, i64 3
  %102 = load i64, ptr %101, align 4
  %slot_offset32 = add i64 %102, 1
  store i64 %slot_offset32, ptr %101, align 4
  %votingType33 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 4
  store i64 %storage_value31, ptr %votingType33, align 4
  %103 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %82, ptr %103)
  %104 = getelementptr i64, ptr %103, i64 3
  %storage_value34 = load i64, ptr %104, align 4
  %105 = getelementptr i64, ptr %82, i64 3
  %106 = load i64, ptr %105, align 4
  %slot_offset35 = add i64 %106, 1
  store i64 %slot_offset35, ptr %105, align 4
  %proposalType36 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 5
  store i64 %storage_value34, ptr %proposalType36, align 4
  %107 = call ptr @heap_malloc(i64 1)
  call void @get_context_data(ptr %107, i64 1)
  %108 = load i64, ptr %107, align 4
  %struct_member37 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 1
  %109 = load i64, ptr %struct_member37, align 4
  %110 = icmp ult i64 %108, %109
  %111 = zext i1 %110 to i64
  call void @builtin_assert(i64 %111)
  %112 = load i64, ptr %_support, align 4
  %113 = trunc i64 %112 to i1
  br i1 %113, label %then, label %else

then:                                             ; preds = %endfor
  %struct_member38 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 2
  %struct_member39 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 2
  %114 = load i64, ptr %struct_member39, align 4
  %115 = load i64, ptr %_weight, align 4
  %116 = add i64 %114, %115
  call void @builtin_range_check(i64 %116)
  store i64 %116, ptr %struct_member38, align 4
  br label %endif

else:                                             ; preds = %endfor
  %struct_member40 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 3
  %struct_member41 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 3
  %117 = load i64, ptr %struct_member41, align 4
  %118 = load i64, ptr %_weight, align 4
  %119 = add i64 %117, %118
  call void @builtin_range_check(i64 %119)
  store i64 %119, ptr %struct_member40, align 4
  br label %endif

endif:                                            ; preds = %else, %then
  %120 = load ptr, ptr %_contentHash, align 8
  %121 = call ptr @heap_malloc(i64 4)
  %122 = getelementptr i64, ptr %121, i64 0
  store i64 0, ptr %122, align 4
  %123 = getelementptr i64, ptr %121, i64 1
  store i64 0, ptr %123, align 4
  %124 = getelementptr i64, ptr %121, i64 2
  store i64 0, ptr %124, align 4
  %125 = getelementptr i64, ptr %121, i64 3
  store i64 0, ptr %125, align 4
  %126 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %121, ptr %126, i64 4)
  %127 = getelementptr i64, ptr %126, i64 4
  call void @memcpy(ptr %120, ptr %127, i64 4)
  %128 = getelementptr i64, ptr %127, i64 4
  %129 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %126, ptr %129, i64 8)
  %proposer42 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 0
  %130 = load ptr, ptr %proposer42, align 8
  call void @set_storage(ptr %129, ptr %130)
  %131 = getelementptr i64, ptr %129, i64 3
  %132 = load i64, ptr %131, align 4
  %slot_offset43 = add i64 %132, 1
  store i64 %slot_offset43, ptr %131, align 4
  %deadline44 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 1
  %133 = load i64, ptr %deadline44, align 4
  %134 = call ptr @heap_malloc(i64 4)
  %135 = getelementptr i64, ptr %134, i64 0
  store i64 0, ptr %135, align 4
  %136 = getelementptr i64, ptr %134, i64 1
  store i64 0, ptr %136, align 4
  %137 = getelementptr i64, ptr %134, i64 2
  store i64 0, ptr %137, align 4
  %138 = getelementptr i64, ptr %134, i64 3
  store i64 %133, ptr %138, align 4
  call void @set_storage(ptr %129, ptr %134)
  %139 = getelementptr i64, ptr %129, i64 3
  %140 = load i64, ptr %139, align 4
  %slot_offset45 = add i64 %140, 1
  store i64 %slot_offset45, ptr %139, align 4
  %totalSupport46 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 2
  %141 = load i64, ptr %totalSupport46, align 4
  %142 = call ptr @heap_malloc(i64 4)
  %143 = getelementptr i64, ptr %142, i64 0
  store i64 0, ptr %143, align 4
  %144 = getelementptr i64, ptr %142, i64 1
  store i64 0, ptr %144, align 4
  %145 = getelementptr i64, ptr %142, i64 2
  store i64 0, ptr %145, align 4
  %146 = getelementptr i64, ptr %142, i64 3
  store i64 %141, ptr %146, align 4
  call void @set_storage(ptr %129, ptr %142)
  %147 = getelementptr i64, ptr %129, i64 3
  %148 = load i64, ptr %147, align 4
  %slot_offset47 = add i64 %148, 1
  store i64 %slot_offset47, ptr %147, align 4
  %totalAgainst48 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 3
  %149 = load i64, ptr %totalAgainst48, align 4
  %150 = call ptr @heap_malloc(i64 4)
  %151 = getelementptr i64, ptr %150, i64 0
  store i64 0, ptr %151, align 4
  %152 = getelementptr i64, ptr %150, i64 1
  store i64 0, ptr %152, align 4
  %153 = getelementptr i64, ptr %150, i64 2
  store i64 0, ptr %153, align 4
  %154 = getelementptr i64, ptr %150, i64 3
  store i64 %149, ptr %154, align 4
  call void @set_storage(ptr %129, ptr %150)
  %155 = getelementptr i64, ptr %129, i64 3
  %156 = load i64, ptr %155, align 4
  %slot_offset49 = add i64 %156, 1
  store i64 %slot_offset49, ptr %155, align 4
  %votingType50 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 4
  %157 = load i64, ptr %votingType50, align 4
  %158 = call ptr @heap_malloc(i64 4)
  %159 = getelementptr i64, ptr %158, i64 0
  store i64 0, ptr %159, align 4
  %160 = getelementptr i64, ptr %158, i64 1
  store i64 0, ptr %160, align 4
  %161 = getelementptr i64, ptr %158, i64 2
  store i64 0, ptr %161, align 4
  %162 = getelementptr i64, ptr %158, i64 3
  store i64 %157, ptr %162, align 4
  call void @set_storage(ptr %129, ptr %158)
  %163 = getelementptr i64, ptr %129, i64 3
  %164 = load i64, ptr %163, align 4
  %slot_offset51 = add i64 %164, 1
  store i64 %slot_offset51, ptr %163, align 4
  %proposalType52 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %83, i32 0, i32 5
  %165 = load i64, ptr %proposalType52, align 4
  %166 = call ptr @heap_malloc(i64 4)
  %167 = getelementptr i64, ptr %166, i64 0
  store i64 0, ptr %167, align 4
  %168 = getelementptr i64, ptr %166, i64 1
  store i64 0, ptr %168, align 4
  %169 = getelementptr i64, ptr %166, i64 2
  store i64 0, ptr %169, align 4
  %170 = getelementptr i64, ptr %166, i64 3
  store i64 %165, ptr %170, align 4
  call void @set_storage(ptr %129, ptr %166)
  %171 = call ptr @heap_malloc(i64 4)
  %172 = getelementptr i64, ptr %171, i64 0
  call void @get_context_data(ptr %172, i64 8)
  %173 = getelementptr i64, ptr %171, i64 1
  call void @get_context_data(ptr %173, i64 9)
  %174 = getelementptr i64, ptr %171, i64 2
  call void @get_context_data(ptr %174, i64 10)
  %175 = getelementptr i64, ptr %171, i64 3
  call void @get_context_data(ptr %175, i64 11)
  %176 = call ptr @heap_malloc(i64 4)
  %177 = getelementptr i64, ptr %176, i64 0
  store i64 0, ptr %177, align 4
  %178 = getelementptr i64, ptr %176, i64 1
  store i64 0, ptr %178, align 4
  %179 = getelementptr i64, ptr %176, i64 2
  store i64 0, ptr %179, align 4
  %180 = getelementptr i64, ptr %176, i64 3
  store i64 2, ptr %180, align 4
  %181 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %176, ptr %181, i64 4)
  %182 = getelementptr i64, ptr %181, i64 4
  call void @memcpy(ptr %171, ptr %182, i64 4)
  %183 = getelementptr i64, ptr %182, i64 4
  %184 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %181, ptr %184, i64 8)
  %185 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %184, ptr %185)
  %length53 = getelementptr i64, ptr %185, i64 3
  %186 = load i64, ptr %length53, align 4
  %187 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %184, ptr %187, i64 4)
  %hash_value_low = getelementptr i64, ptr %187, i64 3
  %188 = load i64, ptr %hash_value_low, align 4
  %189 = mul i64 %186, 1
  %storage_array_offset = add i64 %188, %189
  store i64 %storage_array_offset, ptr %hash_value_low, align 4
  %190 = load ptr, ptr %_contentHash, align 8
  call void @set_storage(ptr %187, ptr %190)
  %new_length = add i64 %186, 1
  %191 = call ptr @heap_malloc(i64 4)
  %192 = getelementptr i64, ptr %191, i64 0
  store i64 0, ptr %192, align 4
  %193 = getelementptr i64, ptr %191, i64 1
  store i64 0, ptr %193, align 4
  %194 = getelementptr i64, ptr %191, i64 2
  store i64 0, ptr %194, align 4
  %195 = getelementptr i64, ptr %191, i64 3
  store i64 %new_length, ptr %195, align 4
  call void @set_storage(ptr %184, ptr %191)
  ret void
}

define ptr @getProposal(ptr %0) {
entry:
  %_contentHash = alloca ptr, align 8
  store ptr %0, ptr %_contentHash, align 8
  %1 = load ptr, ptr %_contentHash, align 8
  %2 = call ptr @heap_malloc(i64 4)
  %3 = getelementptr i64, ptr %2, i64 0
  store i64 0, ptr %3, align 4
  %4 = getelementptr i64, ptr %2, i64 1
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %2, i64 2
  store i64 0, ptr %5, align 4
  %6 = getelementptr i64, ptr %2, i64 3
  store i64 0, ptr %6, align 4
  %7 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %2, ptr %7, i64 4)
  %8 = getelementptr i64, ptr %7, i64 4
  call void @memcpy(ptr %1, ptr %8, i64 4)
  %9 = getelementptr i64, ptr %8, i64 4
  %10 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %7, ptr %10, i64 8)
  %11 = call ptr @heap_malloc(i64 6)
  %12 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %12)
  %13 = getelementptr i64, ptr %10, i64 3
  %14 = load i64, ptr %13, align 4
  %slot_offset = add i64 %14, 1
  store i64 %slot_offset, ptr %13, align 4
  %proposer = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 0
  store ptr %12, ptr %proposer, align 8
  %15 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %15)
  %16 = getelementptr i64, ptr %15, i64 3
  %storage_value = load i64, ptr %16, align 4
  %17 = getelementptr i64, ptr %10, i64 3
  %18 = load i64, ptr %17, align 4
  %slot_offset1 = add i64 %18, 1
  store i64 %slot_offset1, ptr %17, align 4
  %deadline = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 1
  store i64 %storage_value, ptr %deadline, align 4
  %19 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %19)
  %20 = getelementptr i64, ptr %19, i64 3
  %storage_value2 = load i64, ptr %20, align 4
  %21 = getelementptr i64, ptr %10, i64 3
  %22 = load i64, ptr %21, align 4
  %slot_offset3 = add i64 %22, 1
  store i64 %slot_offset3, ptr %21, align 4
  %totalSupport = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 2
  store i64 %storage_value2, ptr %totalSupport, align 4
  %23 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %23)
  %24 = getelementptr i64, ptr %23, i64 3
  %storage_value4 = load i64, ptr %24, align 4
  %25 = getelementptr i64, ptr %10, i64 3
  %26 = load i64, ptr %25, align 4
  %slot_offset5 = add i64 %26, 1
  store i64 %slot_offset5, ptr %25, align 4
  %totalAgainst = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 3
  store i64 %storage_value4, ptr %totalAgainst, align 4
  %27 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %27)
  %28 = getelementptr i64, ptr %27, i64 3
  %storage_value6 = load i64, ptr %28, align 4
  %29 = getelementptr i64, ptr %10, i64 3
  %30 = load i64, ptr %29, align 4
  %slot_offset7 = add i64 %30, 1
  store i64 %slot_offset7, ptr %29, align 4
  %votingType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 4
  store i64 %storage_value6, ptr %votingType, align 4
  %31 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %10, ptr %31)
  %32 = getelementptr i64, ptr %31, i64 3
  %storage_value8 = load i64, ptr %32, align 4
  %33 = getelementptr i64, ptr %10, i64 3
  %34 = load i64, ptr %33, align 4
  %slot_offset9 = add i64 %34, 1
  store i64 %slot_offset9, ptr %33, align 4
  %proposalType = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %11, i32 0, i32 5
  store i64 %storage_value8, ptr %proposalType, align 4
  ret ptr %11
}

define ptr @getProposalsByOwner(ptr %0) {
entry:
  %1 = alloca ptr, align 8
  %index_alloca = alloca i64, align 8
  %_owner = alloca ptr, align 8
  store ptr %0, ptr %_owner, align 8
  %2 = load ptr, ptr %_owner, align 8
  %3 = call ptr @heap_malloc(i64 4)
  %4 = getelementptr i64, ptr %3, i64 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %3, i64 1
  store i64 0, ptr %5, align 4
  %6 = getelementptr i64, ptr %3, i64 2
  store i64 0, ptr %6, align 4
  %7 = getelementptr i64, ptr %3, i64 3
  store i64 1, ptr %7, align 4
  %8 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %3, ptr %8, i64 4)
  %9 = getelementptr i64, ptr %8, i64 4
  call void @memcpy(ptr %2, ptr %9, i64 4)
  %10 = getelementptr i64, ptr %9, i64 4
  %11 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %8, ptr %11, i64 8)
  %12 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %11, ptr %12)
  %length = getelementptr i64, ptr %12, i64 3
  %13 = load i64, ptr %length, align 4
  %14 = call ptr @vector_new(i64 %13)
  %15 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %11, ptr %15, i64 4)
  store i64 0, ptr %index_alloca, align 4
  store ptr %15, ptr %1, align 8
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, %13
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %16 = load ptr, ptr %1, align 8
  %vector_data = getelementptr i64, ptr %14, i64 1
  %index_access = getelementptr ptr, ptr %vector_data, i64 %index_value
  %17 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %16, ptr %17)
  %18 = getelementptr i64, ptr %16, i64 3
  %19 = load i64, ptr %18, align 4
  %slot_offset = add i64 %19, 1
  store i64 %slot_offset, ptr %18, align 4
  store ptr %17, ptr %index_access, align 8
  store ptr %16, ptr %1, align 8
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  ret ptr %14
}

define ptr @getProposalsByVoter(ptr %0) {
entry:
  %1 = alloca ptr, align 8
  %index_alloca = alloca i64, align 8
  %_voter = alloca ptr, align 8
  store ptr %0, ptr %_voter, align 8
  %2 = load ptr, ptr %_voter, align 8
  %3 = call ptr @heap_malloc(i64 4)
  %4 = getelementptr i64, ptr %3, i64 0
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %3, i64 1
  store i64 0, ptr %5, align 4
  %6 = getelementptr i64, ptr %3, i64 2
  store i64 0, ptr %6, align 4
  %7 = getelementptr i64, ptr %3, i64 3
  store i64 2, ptr %7, align 4
  %8 = call ptr @heap_malloc(i64 8)
  call void @memcpy(ptr %3, ptr %8, i64 4)
  %9 = getelementptr i64, ptr %8, i64 4
  call void @memcpy(ptr %2, ptr %9, i64 4)
  %10 = getelementptr i64, ptr %9, i64 4
  %11 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %8, ptr %11, i64 8)
  %12 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %11, ptr %12)
  %length = getelementptr i64, ptr %12, i64 3
  %13 = load i64, ptr %length, align 4
  %14 = call ptr @vector_new(i64 %13)
  %15 = call ptr @heap_malloc(i64 4)
  call void @poseidon_hash(ptr %11, ptr %15, i64 4)
  store i64 0, ptr %index_alloca, align 4
  store ptr %15, ptr %1, align 8
  br label %cond

cond:                                             ; preds = %body, %entry
  %index_value = load i64, ptr %index_alloca, align 4
  %loop_cond = icmp ult i64 %index_value, %13
  br i1 %loop_cond, label %body, label %done

body:                                             ; preds = %cond
  %16 = load ptr, ptr %1, align 8
  %vector_data = getelementptr i64, ptr %14, i64 1
  %index_access = getelementptr ptr, ptr %vector_data, i64 %index_value
  %17 = call ptr @heap_malloc(i64 4)
  call void @get_storage(ptr %16, ptr %17)
  %18 = getelementptr i64, ptr %16, i64 3
  %19 = load i64, ptr %18, align 4
  %slot_offset = add i64 %19, 1
  store i64 %slot_offset, ptr %18, align 4
  store ptr %17, ptr %index_access, align 8
  store ptr %16, ptr %1, align 8
  %next_index = add i64 %index_value, 1
  store i64 %next_index, ptr %index_alloca, align 4
  br label %cond

done:                                             ; preds = %cond
  ret ptr %14
}

define void @function_dispatch(i64 %0, i64 %1, ptr %2) {
entry:
  %index_ptr46 = alloca i64, align 8
  %buffer_offset44 = alloca i64, align 8
  %index_ptr31 = alloca i64, align 8
  %array_size30 = alloca i64, align 8
  %index_ptr18 = alloca i64, align 8
  %buffer_offset = alloca i64, align 8
  %index_ptr = alloca i64, align 8
  %array_size = alloca i64, align 8
  switch i64 %0, label %missing_function [
    i64 86928995, label %func_0_dispatch
    i64 2465217104, label %func_1_dispatch
    i64 2916530895, label %func_2_dispatch
    i64 2880503592, label %func_3_dispatch
    i64 2566425647, label %func_4_dispatch
  ]

missing_function:                                 ; preds = %entry
  unreachable

func_0_dispatch:                                  ; preds = %entry
  %3 = getelementptr ptr, ptr %2, i64 0
  %4 = getelementptr ptr, ptr %3, i64 4
  %5 = load i64, ptr %4, align 4
  %6 = getelementptr ptr, ptr %4, i64 1
  %7 = load i64, ptr %6, align 4
  %8 = getelementptr ptr, ptr %6, i64 1
  %9 = load i64, ptr %8, align 4
  call void @createProposal(ptr %3, i64 %5, i64 %7, i64 %9)
  %10 = call ptr @heap_malloc(i64 1)
  store i64 0, ptr %10, align 4
  call void @set_tape_data(ptr %10, i64 1)
  ret void

func_1_dispatch:                                  ; preds = %entry
  %11 = getelementptr ptr, ptr %2, i64 0
  %12 = getelementptr ptr, ptr %11, i64 4
  %13 = load i64, ptr %12, align 4
  %14 = getelementptr ptr, ptr %12, i64 1
  %15 = load i64, ptr %14, align 4
  call void @vote(ptr %11, i64 %13, i64 %15)
  %16 = call ptr @heap_malloc(i64 1)
  store i64 0, ptr %16, align 4
  call void @set_tape_data(ptr %16, i64 1)
  ret void

func_2_dispatch:                                  ; preds = %entry
  %17 = getelementptr ptr, ptr %2, i64 0
  %18 = call ptr @getProposal(ptr %17)
  %19 = call ptr @heap_malloc(i64 10)
  %struct_member = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 0
  %strcut_member = load ptr, ptr %struct_member, align 8
  %struct_offset = getelementptr ptr, ptr %19, i64 0
  %20 = getelementptr i64, ptr %strcut_member, i64 0
  %21 = load i64, ptr %20, align 4
  %22 = getelementptr i64, ptr %struct_offset, i64 0
  store i64 %21, ptr %22, align 4
  %23 = getelementptr i64, ptr %strcut_member, i64 1
  %24 = load i64, ptr %23, align 4
  %25 = getelementptr i64, ptr %struct_offset, i64 1
  store i64 %24, ptr %25, align 4
  %26 = getelementptr i64, ptr %strcut_member, i64 2
  %27 = load i64, ptr %26, align 4
  %28 = getelementptr i64, ptr %struct_offset, i64 2
  store i64 %27, ptr %28, align 4
  %29 = getelementptr i64, ptr %strcut_member, i64 3
  %30 = load i64, ptr %29, align 4
  %31 = getelementptr i64, ptr %struct_offset, i64 3
  store i64 %30, ptr %31, align 4
  %struct_member1 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 1
  %strcut_member2 = load i64, ptr %struct_member1, align 4
  %struct_offset3 = getelementptr ptr, ptr %struct_offset, i64 4
  store i64 %strcut_member2, ptr %struct_offset3, align 4
  %struct_member4 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 2
  %strcut_member5 = load i64, ptr %struct_member4, align 4
  %struct_offset6 = getelementptr ptr, ptr %struct_offset3, i64 1
  store i64 %strcut_member5, ptr %struct_offset6, align 4
  %struct_member7 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 3
  %strcut_member8 = load i64, ptr %struct_member7, align 4
  %struct_offset9 = getelementptr ptr, ptr %struct_offset6, i64 1
  store i64 %strcut_member8, ptr %struct_offset9, align 4
  %struct_member10 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 4
  %strcut_member11 = load i64, ptr %struct_member10, align 4
  %struct_offset12 = getelementptr ptr, ptr %struct_offset9, i64 1
  store i64 %strcut_member11, ptr %struct_offset12, align 4
  %struct_member13 = getelementptr inbounds { ptr, i64, i64, i64, i64, i64 }, ptr %18, i32 0, i32 5
  %strcut_member14 = load i64, ptr %struct_member13, align 4
  %struct_offset15 = getelementptr ptr, ptr %struct_offset12, i64 1
  store i64 %strcut_member14, ptr %struct_offset15, align 4
  %32 = getelementptr ptr, ptr %19, i64 9
  store i64 9, ptr %32, align 4
  call void @set_tape_data(ptr %19, i64 10)
  ret void

func_3_dispatch:                                  ; preds = %entry
  %33 = getelementptr ptr, ptr %2, i64 0
  %34 = call ptr @getProposalsByOwner(ptr %33)
  store i64 0, ptr %array_size, align 4
  %35 = load i64, ptr %array_size, align 4
  %36 = add i64 %35, 1
  store i64 %36, ptr %array_size, align 4
  store i64 0, ptr %index_ptr, align 4
  br label %cond

cond:                                             ; preds = %next, %func_3_dispatch
  %vector_length = load i64, ptr %34, align 4
  %37 = load i64, ptr %index_ptr, align 4
  %38 = icmp ult i64 %37, %vector_length
  br i1 %38, label %body, label %end_for

body:                                             ; preds = %cond
  %array_index = load i64, ptr %index_ptr, align 4
  %vector_length16 = load i64, ptr %34, align 4
  %39 = sub i64 %vector_length16, 1
  %40 = sub i64 %39, %array_index
  call void @builtin_range_check(i64 %40)
  %vector_data = getelementptr i64, ptr %34, i64 1
  %index_access = getelementptr ptr, ptr %vector_data, i64 %array_index
  %array_element = load ptr, ptr %index_access, align 8
  %41 = load i64, ptr %array_size, align 4
  %42 = add i64 %41, 4
  store i64 %42, ptr %array_size, align 4
  br label %next

next:                                             ; preds = %body
  %index = load i64, ptr %index_ptr, align 4
  %43 = add i64 %index, 1
  store i64 %43, ptr %index_ptr, align 4
  br label %cond

end_for:                                          ; preds = %cond
  %44 = load i64, ptr %array_size, align 4
  %heap_size = add i64 %44, 1
  %45 = call ptr @heap_malloc(i64 %heap_size)
  store i64 0, ptr %buffer_offset, align 4
  %46 = load i64, ptr %buffer_offset, align 4
  %47 = add i64 %46, 1
  store i64 %47, ptr %buffer_offset, align 4
  %48 = getelementptr ptr, ptr %45, i64 %46
  %vector_length17 = load i64, ptr %34, align 4
  store i64 %vector_length17, ptr %48, align 4
  store i64 0, ptr %index_ptr18, align 4
  br label %cond19

cond19:                                           ; preds = %next21, %end_for
  %vector_length23 = load i64, ptr %34, align 4
  %49 = load i64, ptr %index_ptr18, align 4
  %50 = icmp ult i64 %49, %vector_length23
  br i1 %50, label %body20, label %end_for22

body20:                                           ; preds = %cond19
  %array_index24 = load i64, ptr %index_ptr18, align 4
  %vector_length25 = load i64, ptr %34, align 4
  %51 = sub i64 %vector_length25, 1
  %52 = sub i64 %51, %array_index24
  call void @builtin_range_check(i64 %52)
  %vector_data26 = getelementptr i64, ptr %34, i64 1
  %index_access27 = getelementptr ptr, ptr %vector_data26, i64 %array_index24
  %array_element28 = load ptr, ptr %index_access27, align 8
  %53 = load i64, ptr %buffer_offset, align 4
  %54 = getelementptr ptr, ptr %45, i64 %53
  %55 = getelementptr i64, ptr %array_element28, i64 0
  %56 = load i64, ptr %55, align 4
  %57 = getelementptr i64, ptr %54, i64 0
  store i64 %56, ptr %57, align 4
  %58 = getelementptr i64, ptr %array_element28, i64 1
  %59 = load i64, ptr %58, align 4
  %60 = getelementptr i64, ptr %54, i64 1
  store i64 %59, ptr %60, align 4
  %61 = getelementptr i64, ptr %array_element28, i64 2
  %62 = load i64, ptr %61, align 4
  %63 = getelementptr i64, ptr %54, i64 2
  store i64 %62, ptr %63, align 4
  %64 = getelementptr i64, ptr %array_element28, i64 3
  %65 = load i64, ptr %64, align 4
  %66 = getelementptr i64, ptr %54, i64 3
  store i64 %65, ptr %66, align 4
  %67 = load i64, ptr %buffer_offset, align 4
  %68 = add i64 %67, 4
  store i64 %68, ptr %buffer_offset, align 4
  br label %next21

next21:                                           ; preds = %body20
  %index29 = load i64, ptr %index_ptr18, align 4
  %69 = add i64 %index29, 1
  store i64 %69, ptr %index_ptr18, align 4
  br label %cond19

end_for22:                                        ; preds = %cond19
  %70 = load i64, ptr %buffer_offset, align 4
  %71 = getelementptr ptr, ptr %45, i64 %70
  store i64 %44, ptr %71, align 4
  call void @set_tape_data(ptr %45, i64 %heap_size)
  ret void

func_4_dispatch:                                  ; preds = %entry
  %72 = getelementptr ptr, ptr %2, i64 0
  %73 = call ptr @getProposalsByVoter(ptr %72)
  store i64 0, ptr %array_size30, align 4
  %74 = load i64, ptr %array_size30, align 4
  %75 = add i64 %74, 1
  store i64 %75, ptr %array_size30, align 4
  store i64 0, ptr %index_ptr31, align 4
  br label %cond32

cond32:                                           ; preds = %next34, %func_4_dispatch
  %vector_length36 = load i64, ptr %73, align 4
  %76 = load i64, ptr %index_ptr31, align 4
  %77 = icmp ult i64 %76, %vector_length36
  br i1 %77, label %body33, label %end_for35

body33:                                           ; preds = %cond32
  %array_index37 = load i64, ptr %index_ptr31, align 4
  %vector_length38 = load i64, ptr %73, align 4
  %78 = sub i64 %vector_length38, 1
  %79 = sub i64 %78, %array_index37
  call void @builtin_range_check(i64 %79)
  %vector_data39 = getelementptr i64, ptr %73, i64 1
  %index_access40 = getelementptr ptr, ptr %vector_data39, i64 %array_index37
  %array_element41 = load ptr, ptr %index_access40, align 8
  %80 = load i64, ptr %array_size30, align 4
  %81 = add i64 %80, 4
  store i64 %81, ptr %array_size30, align 4
  br label %next34

next34:                                           ; preds = %body33
  %index42 = load i64, ptr %index_ptr31, align 4
  %82 = add i64 %index42, 1
  store i64 %82, ptr %index_ptr31, align 4
  br label %cond32

end_for35:                                        ; preds = %cond32
  %83 = load i64, ptr %array_size30, align 4
  %heap_size43 = add i64 %83, 1
  %84 = call ptr @heap_malloc(i64 %heap_size43)
  store i64 0, ptr %buffer_offset44, align 4
  %85 = load i64, ptr %buffer_offset44, align 4
  %86 = add i64 %85, 1
  store i64 %86, ptr %buffer_offset44, align 4
  %87 = getelementptr ptr, ptr %84, i64 %85
  %vector_length45 = load i64, ptr %73, align 4
  store i64 %vector_length45, ptr %87, align 4
  store i64 0, ptr %index_ptr46, align 4
  br label %cond47

cond47:                                           ; preds = %next49, %end_for35
  %vector_length51 = load i64, ptr %73, align 4
  %88 = load i64, ptr %index_ptr46, align 4
  %89 = icmp ult i64 %88, %vector_length51
  br i1 %89, label %body48, label %end_for50

body48:                                           ; preds = %cond47
  %array_index52 = load i64, ptr %index_ptr46, align 4
  %vector_length53 = load i64, ptr %73, align 4
  %90 = sub i64 %vector_length53, 1
  %91 = sub i64 %90, %array_index52
  call void @builtin_range_check(i64 %91)
  %vector_data54 = getelementptr i64, ptr %73, i64 1
  %index_access55 = getelementptr ptr, ptr %vector_data54, i64 %array_index52
  %array_element56 = load ptr, ptr %index_access55, align 8
  %92 = load i64, ptr %buffer_offset44, align 4
  %93 = getelementptr ptr, ptr %84, i64 %92
  %94 = getelementptr i64, ptr %array_element56, i64 0
  %95 = load i64, ptr %94, align 4
  %96 = getelementptr i64, ptr %93, i64 0
  store i64 %95, ptr %96, align 4
  %97 = getelementptr i64, ptr %array_element56, i64 1
  %98 = load i64, ptr %97, align 4
  %99 = getelementptr i64, ptr %93, i64 1
  store i64 %98, ptr %99, align 4
  %100 = getelementptr i64, ptr %array_element56, i64 2
  %101 = load i64, ptr %100, align 4
  %102 = getelementptr i64, ptr %93, i64 2
  store i64 %101, ptr %102, align 4
  %103 = getelementptr i64, ptr %array_element56, i64 3
  %104 = load i64, ptr %103, align 4
  %105 = getelementptr i64, ptr %93, i64 3
  store i64 %104, ptr %105, align 4
  %106 = load i64, ptr %buffer_offset44, align 4
  %107 = add i64 %106, 4
  store i64 %107, ptr %buffer_offset44, align 4
  br label %next49

next49:                                           ; preds = %body48
  %index57 = load i64, ptr %index_ptr46, align 4
  %108 = add i64 %index57, 1
  store i64 %108, ptr %index_ptr46, align 4
  br label %cond47

end_for50:                                        ; preds = %cond47
  %109 = load i64, ptr %buffer_offset44, align 4
  %110 = getelementptr ptr, ptr %84, i64 %109
  store i64 %83, ptr %110, align 4
  call void @set_tape_data(ptr %84, i64 %heap_size43)
  ret void
}

define void @main() {
entry:
  %0 = call ptr @heap_malloc(i64 13)
  call void @get_tape_data(ptr %0, i64 13)
  %function_selector = load i64, ptr %0, align 4
  %1 = call ptr @heap_malloc(i64 14)
  call void @get_tape_data(ptr %1, i64 14)
  %input_length = load i64, ptr %1, align 4
  %2 = add i64 %input_length, 14
  %3 = call ptr @heap_malloc(i64 %2)
  call void @get_tape_data(ptr %3, i64 %2)
  call void @function_dispatch(i64 %function_selector, i64 %input_length, ptr %3)
  ret void
}
