; ModuleID = 'Voting'
source_filename = "examples/source/storage/vote.ola"

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

define void @contract_init(ptr %0) {
entry:
  %i = alloca i64, align 8
  %proposalNames_ = alloca ptr, align 8
  store ptr %0, ptr %proposalNames_, align 8
  %1 = load ptr, ptr %proposalNames_, align 8
  store i64 0, ptr %i, align 4
  br label %cond

cond:                                             ; preds = %next, %entry
  %2 = load i64, ptr %i, align 4
  %length = load i64, ptr %1, align 4
  %3 = icmp ult i64 %2, %length
  br i1 %3, label %body, label %endfor

body:                                             ; preds = %cond
  %4 = call i64 @vector_new(i64 4)
  %heap_start = sub i64 %4, 4
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %5 = call i64 @vector_new(i64 4)
  %heap_start1 = sub i64 %5, 4
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  store i64 1, ptr %heap_to_ptr2, align 4
  %6 = getelementptr i64, ptr %heap_to_ptr2, i64 1
  store i64 0, ptr %6, align 4
  %7 = getelementptr i64, ptr %heap_to_ptr2, i64 2
  store i64 0, ptr %7, align 4
  %8 = getelementptr i64, ptr %heap_to_ptr2, i64 3
  store i64 0, ptr %8, align 4
  call void @get_storage(ptr %heap_to_ptr2, ptr %heap_to_ptr)
  %storage_value = load i64, ptr %heap_to_ptr, align 4
  %9 = call i64 @vector_new(i64 4)
  %heap_start3 = sub i64 %9, 4
  %heap_to_ptr4 = inttoptr i64 %heap_start3 to ptr
  store i64 1, ptr %heap_to_ptr4, align 4
  %10 = getelementptr i64, ptr %heap_to_ptr4, i64 1
  store i64 0, ptr %10, align 4
  %11 = getelementptr i64, ptr %heap_to_ptr4, i64 2
  store i64 0, ptr %11, align 4
  %12 = getelementptr i64, ptr %heap_to_ptr4, i64 3
  store i64 0, ptr %12, align 4
  %13 = call i64 @vector_new(i64 4)
  %heap_start5 = sub i64 %13, 4
  %heap_to_ptr6 = inttoptr i64 %heap_start5 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr4, ptr %heap_to_ptr6, i64 4)
  %14 = getelementptr i64, ptr %heap_to_ptr6, i64 3
  %15 = load i64, ptr %14, align 4
  %16 = mul i64 %storage_value, 2
  %17 = add i64 %15, %16
  store i64 %17, ptr %14, align 4
  %18 = call i64 @vector_new(i64 2)
  %heap_start7 = sub i64 %18, 2
  %heap_to_ptr8 = inttoptr i64 %heap_start7 to ptr
  %struct_member = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr8, i32 0, i32 0
  %19 = load i64, ptr %i, align 4
  %length9 = load i64, ptr %1, align 4
  %20 = sub i64 %length9, 1
  %21 = sub i64 %20, %19
  call void @builtin_range_check(i64 %21)
  %22 = ptrtoint ptr %1 to i64
  %23 = add i64 %22, 1
  %vector_data = inttoptr i64 %23 to ptr
  %index_access = getelementptr i64, ptr %vector_data, i64 %19
  %24 = load i64, ptr %index_access, align 4
  store i64 %24, ptr %struct_member, align 4
  %struct_member10 = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr8, i32 0, i32 1
  store i64 0, ptr %struct_member10, align 4
  %name = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr8, i32 0, i32 0
  call void @set_storage(ptr %heap_to_ptr6, ptr %name)
  %25 = getelementptr i64, ptr %heap_to_ptr6, i64 3
  %slot_value = load i64, ptr %25, align 4
  %26 = add i64 %slot_value, 1
  %voteCount = getelementptr inbounds { i64, i64 }, ptr %heap_to_ptr8, i32 0, i32 1
  %27 = call i64 @vector_new(i64 4)
  %heap_start11 = sub i64 %27, 4
  %heap_to_ptr12 = inttoptr i64 %heap_start11 to ptr
  store i64 %26, ptr %heap_to_ptr12, align 4
  %28 = getelementptr i64, ptr %heap_to_ptr12, i64 1
  store i64 0, ptr %28, align 4
  %29 = getelementptr i64, ptr %heap_to_ptr12, i64 2
  store i64 0, ptr %29, align 4
  %30 = getelementptr i64, ptr %heap_to_ptr12, i64 3
  store i64 0, ptr %30, align 4
  call void @set_storage(ptr %heap_to_ptr12, ptr %voteCount)
  %new_length = add i64 %storage_value, 1
  %31 = call i64 @vector_new(i64 4)
  %heap_start13 = sub i64 %31, 4
  %heap_to_ptr14 = inttoptr i64 %heap_start13 to ptr
  store i64 1, ptr %heap_to_ptr14, align 4
  %32 = getelementptr i64, ptr %heap_to_ptr14, i64 1
  store i64 0, ptr %32, align 4
  %33 = getelementptr i64, ptr %heap_to_ptr14, i64 2
  store i64 0, ptr %33, align 4
  %34 = getelementptr i64, ptr %heap_to_ptr14, i64 3
  store i64 0, ptr %34, align 4
  %35 = call i64 @vector_new(i64 4)
  %heap_start15 = sub i64 %35, 4
  %heap_to_ptr16 = inttoptr i64 %heap_start15 to ptr
  store i64 %new_length, ptr %heap_to_ptr16, align 4
  %36 = getelementptr i64, ptr %heap_to_ptr16, i64 1
  store i64 0, ptr %36, align 4
  %37 = getelementptr i64, ptr %heap_to_ptr16, i64 2
  store i64 0, ptr %37, align 4
  %38 = getelementptr i64, ptr %heap_to_ptr16, i64 3
  store i64 0, ptr %38, align 4
  call void @set_storage(ptr %heap_to_ptr14, ptr %heap_to_ptr16)
  br label %next

next:                                             ; preds = %body
  %39 = load i64, ptr %i, align 4
  %40 = add i64 %39, 1
  store i64 %40, ptr %i, align 4
  br label %cond

endfor:                                           ; preds = %cond
  ret void
}

define i64 @winningProposal() {
entry:
  %p = alloca i64, align 8
  %winningVoteCount = alloca i64, align 8
  %winningProposal_ = alloca i64, align 8
  store i64 0, ptr %winningProposal_, align 4
  store i64 0, ptr %winningVoteCount, align 4
  store i64 0, ptr %p, align 4
  br label %cond

cond:                                             ; preds = %next, %entry
  %0 = load i64, ptr %p, align 4
  %1 = call i64 @vector_new(i64 4)
  %heap_start = sub i64 %1, 4
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %2 = call i64 @vector_new(i64 4)
  %heap_start1 = sub i64 %2, 4
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  store i64 1, ptr %heap_to_ptr2, align 4
  %3 = getelementptr i64, ptr %heap_to_ptr2, i64 1
  store i64 0, ptr %3, align 4
  %4 = getelementptr i64, ptr %heap_to_ptr2, i64 2
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %heap_to_ptr2, i64 3
  store i64 0, ptr %5, align 4
  call void @get_storage(ptr %heap_to_ptr2, ptr %heap_to_ptr)
  %storage_value = load i64, ptr %heap_to_ptr, align 4
  %6 = icmp ult i64 %0, %storage_value
  br i1 %6, label %body, label %endfor

body:                                             ; preds = %cond
  %7 = load i64, ptr %p, align 4
  %8 = call i64 @vector_new(i64 4)
  %heap_start3 = sub i64 %8, 4
  %heap_to_ptr4 = inttoptr i64 %heap_start3 to ptr
  %9 = call i64 @vector_new(i64 4)
  %heap_start5 = sub i64 %9, 4
  %heap_to_ptr6 = inttoptr i64 %heap_start5 to ptr
  store i64 1, ptr %heap_to_ptr6, align 4
  %10 = getelementptr i64, ptr %heap_to_ptr6, i64 1
  store i64 0, ptr %10, align 4
  %11 = getelementptr i64, ptr %heap_to_ptr6, i64 2
  store i64 0, ptr %11, align 4
  %12 = getelementptr i64, ptr %heap_to_ptr6, i64 3
  store i64 0, ptr %12, align 4
  call void @get_storage(ptr %heap_to_ptr6, ptr %heap_to_ptr4)
  %storage_value7 = load i64, ptr %heap_to_ptr4, align 4
  %13 = sub i64 %storage_value7, 1
  %14 = sub i64 %13, %7
  call void @builtin_range_check(i64 %14)
  %15 = call i64 @vector_new(i64 4)
  %heap_start8 = sub i64 %15, 4
  %heap_to_ptr9 = inttoptr i64 %heap_start8 to ptr
  store i64 1, ptr %heap_to_ptr9, align 4
  %16 = getelementptr i64, ptr %heap_to_ptr9, i64 1
  store i64 0, ptr %16, align 4
  %17 = getelementptr i64, ptr %heap_to_ptr9, i64 2
  store i64 0, ptr %17, align 4
  %18 = getelementptr i64, ptr %heap_to_ptr9, i64 3
  store i64 0, ptr %18, align 4
  %19 = call i64 @vector_new(i64 4)
  %heap_start10 = sub i64 %19, 4
  %heap_to_ptr11 = inttoptr i64 %heap_start10 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr9, ptr %heap_to_ptr11, i64 4)
  %20 = getelementptr i64, ptr %heap_to_ptr11, i64 3
  %21 = load i64, ptr %20, align 4
  %22 = mul i64 %7, 2
  %23 = add i64 %21, %22
  store i64 %23, ptr %20, align 4
  %24 = getelementptr i64, ptr %heap_to_ptr11, i64 3
  %slot_value = load i64, ptr %24, align 4
  %25 = add i64 %slot_value, 1
  %26 = call i64 @vector_new(i64 4)
  %heap_start12 = sub i64 %26, 4
  %heap_to_ptr13 = inttoptr i64 %heap_start12 to ptr
  %27 = call i64 @vector_new(i64 4)
  %heap_start14 = sub i64 %27, 4
  %heap_to_ptr15 = inttoptr i64 %heap_start14 to ptr
  store i64 %25, ptr %heap_to_ptr15, align 4
  %28 = getelementptr i64, ptr %heap_to_ptr15, i64 1
  store i64 0, ptr %28, align 4
  %29 = getelementptr i64, ptr %heap_to_ptr15, i64 2
  store i64 0, ptr %29, align 4
  %30 = getelementptr i64, ptr %heap_to_ptr15, i64 3
  store i64 0, ptr %30, align 4
  call void @get_storage(ptr %heap_to_ptr15, ptr %heap_to_ptr13)
  %storage_value16 = load i64, ptr %heap_to_ptr13, align 4
  %31 = load i64, ptr %winningVoteCount, align 4
  %32 = icmp ugt i64 %storage_value16, %31
  br i1 %32, label %then, label %enif

next:                                             ; preds = %enif
  %33 = load i64, ptr %p, align 4
  %34 = add i64 %33, 1
  store i64 %34, ptr %p, align 4
  br label %cond

endfor:                                           ; preds = %cond
  %35 = load i64, ptr %winningProposal_, align 4
  ret i64 %35

then:                                             ; preds = %body
  %36 = load i64, ptr %p, align 4
  %37 = call i64 @vector_new(i64 4)
  %heap_start17 = sub i64 %37, 4
  %heap_to_ptr18 = inttoptr i64 %heap_start17 to ptr
  %38 = call i64 @vector_new(i64 4)
  %heap_start19 = sub i64 %38, 4
  %heap_to_ptr20 = inttoptr i64 %heap_start19 to ptr
  store i64 1, ptr %heap_to_ptr20, align 4
  %39 = getelementptr i64, ptr %heap_to_ptr20, i64 1
  store i64 0, ptr %39, align 4
  %40 = getelementptr i64, ptr %heap_to_ptr20, i64 2
  store i64 0, ptr %40, align 4
  %41 = getelementptr i64, ptr %heap_to_ptr20, i64 3
  store i64 0, ptr %41, align 4
  call void @get_storage(ptr %heap_to_ptr20, ptr %heap_to_ptr18)
  %storage_value21 = load i64, ptr %heap_to_ptr18, align 4
  %42 = sub i64 %storage_value21, 1
  %43 = sub i64 %42, %36
  call void @builtin_range_check(i64 %43)
  %44 = call i64 @vector_new(i64 4)
  %heap_start22 = sub i64 %44, 4
  %heap_to_ptr23 = inttoptr i64 %heap_start22 to ptr
  store i64 1, ptr %heap_to_ptr23, align 4
  %45 = getelementptr i64, ptr %heap_to_ptr23, i64 1
  store i64 0, ptr %45, align 4
  %46 = getelementptr i64, ptr %heap_to_ptr23, i64 2
  store i64 0, ptr %46, align 4
  %47 = getelementptr i64, ptr %heap_to_ptr23, i64 3
  store i64 0, ptr %47, align 4
  %48 = call i64 @vector_new(i64 4)
  %heap_start24 = sub i64 %48, 4
  %heap_to_ptr25 = inttoptr i64 %heap_start24 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr23, ptr %heap_to_ptr25, i64 4)
  %49 = getelementptr i64, ptr %heap_to_ptr25, i64 3
  %50 = load i64, ptr %49, align 4
  %51 = mul i64 %36, 2
  %52 = add i64 %50, %51
  store i64 %52, ptr %49, align 4
  %53 = getelementptr i64, ptr %heap_to_ptr25, i64 3
  %slot_value26 = load i64, ptr %53, align 4
  %54 = add i64 %slot_value26, 1
  %55 = call i64 @vector_new(i64 4)
  %heap_start27 = sub i64 %55, 4
  %heap_to_ptr28 = inttoptr i64 %heap_start27 to ptr
  %56 = call i64 @vector_new(i64 4)
  %heap_start29 = sub i64 %56, 4
  %heap_to_ptr30 = inttoptr i64 %heap_start29 to ptr
  store i64 %54, ptr %heap_to_ptr30, align 4
  %57 = getelementptr i64, ptr %heap_to_ptr30, i64 1
  store i64 0, ptr %57, align 4
  %58 = getelementptr i64, ptr %heap_to_ptr30, i64 2
  store i64 0, ptr %58, align 4
  %59 = getelementptr i64, ptr %heap_to_ptr30, i64 3
  store i64 0, ptr %59, align 4
  call void @get_storage(ptr %heap_to_ptr30, ptr %heap_to_ptr28)
  %storage_value31 = load i64, ptr %heap_to_ptr28, align 4
  %60 = load i64, ptr %p, align 4
  br label %enif

enif:                                             ; preds = %then, %body
  br label %next
}

define i64 @getWinnerName() {
entry:
  %winnerName = alloca i64, align 8
  %_winningProposal = alloca i64, align 8
  %0 = call i64 @winningProposal()
  store i64 %0, ptr %_winningProposal, align 4
  %1 = load i64, ptr %_winningProposal, align 4
  %2 = call i64 @vector_new(i64 4)
  %heap_start = sub i64 %2, 4
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %3 = call i64 @vector_new(i64 4)
  %heap_start1 = sub i64 %3, 4
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  store i64 1, ptr %heap_to_ptr2, align 4
  %4 = getelementptr i64, ptr %heap_to_ptr2, i64 1
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %heap_to_ptr2, i64 2
  store i64 0, ptr %5, align 4
  %6 = getelementptr i64, ptr %heap_to_ptr2, i64 3
  store i64 0, ptr %6, align 4
  call void @get_storage(ptr %heap_to_ptr2, ptr %heap_to_ptr)
  %storage_value = load i64, ptr %heap_to_ptr, align 4
  %7 = sub i64 %storage_value, 1
  %8 = sub i64 %7, %1
  call void @builtin_range_check(i64 %8)
  %9 = call i64 @vector_new(i64 4)
  %heap_start3 = sub i64 %9, 4
  %heap_to_ptr4 = inttoptr i64 %heap_start3 to ptr
  store i64 1, ptr %heap_to_ptr4, align 4
  %10 = getelementptr i64, ptr %heap_to_ptr4, i64 1
  store i64 0, ptr %10, align 4
  %11 = getelementptr i64, ptr %heap_to_ptr4, i64 2
  store i64 0, ptr %11, align 4
  %12 = getelementptr i64, ptr %heap_to_ptr4, i64 3
  store i64 0, ptr %12, align 4
  %13 = call i64 @vector_new(i64 4)
  %heap_start5 = sub i64 %13, 4
  %heap_to_ptr6 = inttoptr i64 %heap_start5 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr4, ptr %heap_to_ptr6, i64 4)
  %14 = getelementptr i64, ptr %heap_to_ptr6, i64 3
  %15 = load i64, ptr %14, align 4
  %16 = mul i64 %1, 2
  %17 = add i64 %15, %16
  store i64 %17, ptr %14, align 4
  %18 = getelementptr i64, ptr %heap_to_ptr6, i64 3
  %slot_value = load i64, ptr %18, align 4
  %19 = add i64 %slot_value, 0
  %20 = call i64 @vector_new(i64 4)
  %heap_start7 = sub i64 %20, 4
  %heap_to_ptr8 = inttoptr i64 %heap_start7 to ptr
  %21 = call i64 @vector_new(i64 4)
  %heap_start9 = sub i64 %21, 4
  %heap_to_ptr10 = inttoptr i64 %heap_start9 to ptr
  store i64 %19, ptr %heap_to_ptr10, align 4
  %22 = getelementptr i64, ptr %heap_to_ptr10, i64 1
  store i64 0, ptr %22, align 4
  %23 = getelementptr i64, ptr %heap_to_ptr10, i64 2
  store i64 0, ptr %23, align 4
  %24 = getelementptr i64, ptr %heap_to_ptr10, i64 3
  store i64 0, ptr %24, align 4
  call void @get_storage(ptr %heap_to_ptr10, ptr %heap_to_ptr8)
  %storage_value11 = load i64, ptr %heap_to_ptr8, align 4
  store i64 %storage_value11, ptr %winnerName, align 4
  %25 = load i64, ptr %winnerName, align 4
  ret i64 %25
}

define void @vote_proposal(i64 %0) {
entry:
  %sender = alloca i64, align 8
  %msgSender = alloca ptr, align 8
  %proposal_ = alloca i64, align 8
  store i64 %0, ptr %proposal_, align 4
  %1 = call ptr @get_caller()
  store ptr %1, ptr %msgSender, align 8
  %2 = load ptr, ptr %msgSender, align 8
  %3 = call i64 @vector_new(i64 4)
  %heap_start = sub i64 %3, 4
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  store i64 0, ptr %heap_to_ptr, align 4
  %4 = getelementptr i64, ptr %heap_to_ptr, i64 1
  store i64 0, ptr %4, align 4
  %5 = getelementptr i64, ptr %heap_to_ptr, i64 2
  store i64 0, ptr %5, align 4
  %6 = getelementptr i64, ptr %heap_to_ptr, i64 3
  store i64 0, ptr %6, align 4
  %7 = call i64 @vector_new(i64 8)
  %heap_start1 = sub i64 %7, 8
  %heap_to_ptr2 = inttoptr i64 %heap_start1 to ptr
  %8 = inttoptr i64 %heap_start1 to ptr
  call void @mempcy(ptr %heap_to_ptr, ptr %8, i64 4)
  %next_dest_offset = add i64 %heap_start1, 4
  %9 = inttoptr i64 %next_dest_offset to ptr
  call void @mempcy(ptr %2, ptr %9, i64 4)
  %10 = call i64 @vector_new(i64 4)
  %heap_start3 = sub i64 %10, 4
  %heap_to_ptr4 = inttoptr i64 %heap_start3 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr2, ptr %heap_to_ptr4, i64 8)
  %11 = getelementptr i64, ptr %heap_to_ptr4, i64 3
  %slot_value = load i64, ptr %11, align 4
  %12 = add i64 %slot_value, 0
  %13 = call i64 @vector_new(i64 4)
  %heap_start5 = sub i64 %13, 4
  %heap_to_ptr6 = inttoptr i64 %heap_start5 to ptr
  %14 = call i64 @vector_new(i64 4)
  %heap_start7 = sub i64 %14, 4
  %heap_to_ptr8 = inttoptr i64 %heap_start7 to ptr
  store i64 %12, ptr %heap_to_ptr8, align 4
  %15 = getelementptr i64, ptr %heap_to_ptr8, i64 1
  store i64 0, ptr %15, align 4
  %16 = getelementptr i64, ptr %heap_to_ptr8, i64 2
  store i64 0, ptr %16, align 4
  %17 = getelementptr i64, ptr %heap_to_ptr8, i64 3
  store i64 0, ptr %17, align 4
  call void @get_storage(ptr %heap_to_ptr8, ptr %heap_to_ptr6)
  %storage_value = load i64, ptr %heap_to_ptr6, align 4
  %18 = icmp eq i64 %storage_value, 0
  %19 = zext i1 %18 to i64
  call void @builtin_assert(i64 %19)
  %20 = load ptr, ptr %msgSender, align 8
  %21 = call i64 @vector_new(i64 4)
  %heap_start9 = sub i64 %21, 4
  %heap_to_ptr10 = inttoptr i64 %heap_start9 to ptr
  store i64 0, ptr %heap_to_ptr10, align 4
  %22 = getelementptr i64, ptr %heap_to_ptr10, i64 1
  store i64 0, ptr %22, align 4
  %23 = getelementptr i64, ptr %heap_to_ptr10, i64 2
  store i64 0, ptr %23, align 4
  %24 = getelementptr i64, ptr %heap_to_ptr10, i64 3
  store i64 0, ptr %24, align 4
  %25 = call i64 @vector_new(i64 8)
  %heap_start11 = sub i64 %25, 8
  %heap_to_ptr12 = inttoptr i64 %heap_start11 to ptr
  %26 = inttoptr i64 %heap_start11 to ptr
  call void @mempcy(ptr %heap_to_ptr10, ptr %26, i64 4)
  %next_dest_offset13 = add i64 %heap_start11, 4
  %27 = inttoptr i64 %next_dest_offset13 to ptr
  call void @mempcy(ptr %20, ptr %27, i64 4)
  %28 = call i64 @vector_new(i64 4)
  %heap_start14 = sub i64 %28, 4
  %heap_to_ptr15 = inttoptr i64 %heap_start14 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr12, ptr %heap_to_ptr15, i64 8)
  store ptr %heap_to_ptr15, ptr %sender, align 8
  %29 = load i64, ptr %sender, align 4
  %30 = add i64 %29, 0
  %31 = call i64 @vector_new(i64 4)
  %heap_start16 = sub i64 %31, 4
  %heap_to_ptr17 = inttoptr i64 %heap_start16 to ptr
  store i64 %30, ptr %heap_to_ptr17, align 4
  %32 = getelementptr i64, ptr %heap_to_ptr17, i64 1
  store i64 0, ptr %32, align 4
  %33 = getelementptr i64, ptr %heap_to_ptr17, i64 2
  store i64 0, ptr %33, align 4
  %34 = getelementptr i64, ptr %heap_to_ptr17, i64 3
  store i64 0, ptr %34, align 4
  %35 = call i64 @vector_new(i64 4)
  %heap_start18 = sub i64 %35, 4
  %heap_to_ptr19 = inttoptr i64 %heap_start18 to ptr
  store i64 1, ptr %heap_to_ptr19, align 4
  %36 = getelementptr i64, ptr %heap_to_ptr19, i64 1
  store i64 0, ptr %36, align 4
  %37 = getelementptr i64, ptr %heap_to_ptr19, i64 2
  store i64 0, ptr %37, align 4
  %38 = getelementptr i64, ptr %heap_to_ptr19, i64 3
  store i64 0, ptr %38, align 4
  call void @set_storage(ptr %heap_to_ptr17, ptr %heap_to_ptr19)
  %39 = load i64, ptr %sender, align 4
  %40 = add i64 %39, 1
  %41 = load i64, ptr %proposal_, align 4
  %42 = call i64 @vector_new(i64 4)
  %heap_start20 = sub i64 %42, 4
  %heap_to_ptr21 = inttoptr i64 %heap_start20 to ptr
  store i64 %40, ptr %heap_to_ptr21, align 4
  %43 = getelementptr i64, ptr %heap_to_ptr21, i64 1
  store i64 0, ptr %43, align 4
  %44 = getelementptr i64, ptr %heap_to_ptr21, i64 2
  store i64 0, ptr %44, align 4
  %45 = getelementptr i64, ptr %heap_to_ptr21, i64 3
  store i64 0, ptr %45, align 4
  %46 = call i64 @vector_new(i64 4)
  %heap_start22 = sub i64 %46, 4
  %heap_to_ptr23 = inttoptr i64 %heap_start22 to ptr
  store i64 %41, ptr %heap_to_ptr23, align 4
  %47 = getelementptr i64, ptr %heap_to_ptr23, i64 1
  store i64 0, ptr %47, align 4
  %48 = getelementptr i64, ptr %heap_to_ptr23, i64 2
  store i64 0, ptr %48, align 4
  %49 = getelementptr i64, ptr %heap_to_ptr23, i64 3
  store i64 0, ptr %49, align 4
  call void @set_storage(ptr %heap_to_ptr21, ptr %heap_to_ptr23)
  %50 = load i64, ptr %proposal_, align 4
  %51 = call i64 @vector_new(i64 4)
  %heap_start24 = sub i64 %51, 4
  %heap_to_ptr25 = inttoptr i64 %heap_start24 to ptr
  %52 = call i64 @vector_new(i64 4)
  %heap_start26 = sub i64 %52, 4
  %heap_to_ptr27 = inttoptr i64 %heap_start26 to ptr
  store i64 1, ptr %heap_to_ptr27, align 4
  %53 = getelementptr i64, ptr %heap_to_ptr27, i64 1
  store i64 0, ptr %53, align 4
  %54 = getelementptr i64, ptr %heap_to_ptr27, i64 2
  store i64 0, ptr %54, align 4
  %55 = getelementptr i64, ptr %heap_to_ptr27, i64 3
  store i64 0, ptr %55, align 4
  call void @get_storage(ptr %heap_to_ptr27, ptr %heap_to_ptr25)
  %storage_value28 = load i64, ptr %heap_to_ptr25, align 4
  %56 = sub i64 %storage_value28, 1
  %57 = sub i64 %56, %50
  call void @builtin_range_check(i64 %57)
  %58 = call i64 @vector_new(i64 4)
  %heap_start29 = sub i64 %58, 4
  %heap_to_ptr30 = inttoptr i64 %heap_start29 to ptr
  store i64 1, ptr %heap_to_ptr30, align 4
  %59 = getelementptr i64, ptr %heap_to_ptr30, i64 1
  store i64 0, ptr %59, align 4
  %60 = getelementptr i64, ptr %heap_to_ptr30, i64 2
  store i64 0, ptr %60, align 4
  %61 = getelementptr i64, ptr %heap_to_ptr30, i64 3
  store i64 0, ptr %61, align 4
  %62 = call i64 @vector_new(i64 4)
  %heap_start31 = sub i64 %62, 4
  %heap_to_ptr32 = inttoptr i64 %heap_start31 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr30, ptr %heap_to_ptr32, i64 4)
  %63 = getelementptr i64, ptr %heap_to_ptr32, i64 3
  %64 = load i64, ptr %63, align 4
  %65 = mul i64 %50, 2
  %66 = add i64 %64, %65
  store i64 %66, ptr %63, align 4
  %67 = getelementptr i64, ptr %heap_to_ptr32, i64 3
  %slot_value33 = load i64, ptr %67, align 4
  %68 = add i64 %slot_value33, 1
  %69 = load i64, ptr %proposal_, align 4
  %70 = call i64 @vector_new(i64 4)
  %heap_start34 = sub i64 %70, 4
  %heap_to_ptr35 = inttoptr i64 %heap_start34 to ptr
  %71 = call i64 @vector_new(i64 4)
  %heap_start36 = sub i64 %71, 4
  %heap_to_ptr37 = inttoptr i64 %heap_start36 to ptr
  store i64 1, ptr %heap_to_ptr37, align 4
  %72 = getelementptr i64, ptr %heap_to_ptr37, i64 1
  store i64 0, ptr %72, align 4
  %73 = getelementptr i64, ptr %heap_to_ptr37, i64 2
  store i64 0, ptr %73, align 4
  %74 = getelementptr i64, ptr %heap_to_ptr37, i64 3
  store i64 0, ptr %74, align 4
  call void @get_storage(ptr %heap_to_ptr37, ptr %heap_to_ptr35)
  %storage_value38 = load i64, ptr %heap_to_ptr35, align 4
  %75 = sub i64 %storage_value38, 1
  %76 = sub i64 %75, %69
  call void @builtin_range_check(i64 %76)
  %77 = call i64 @vector_new(i64 4)
  %heap_start39 = sub i64 %77, 4
  %heap_to_ptr40 = inttoptr i64 %heap_start39 to ptr
  store i64 1, ptr %heap_to_ptr40, align 4
  %78 = getelementptr i64, ptr %heap_to_ptr40, i64 1
  store i64 0, ptr %78, align 4
  %79 = getelementptr i64, ptr %heap_to_ptr40, i64 2
  store i64 0, ptr %79, align 4
  %80 = getelementptr i64, ptr %heap_to_ptr40, i64 3
  store i64 0, ptr %80, align 4
  %81 = call i64 @vector_new(i64 4)
  %heap_start41 = sub i64 %81, 4
  %heap_to_ptr42 = inttoptr i64 %heap_start41 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr40, ptr %heap_to_ptr42, i64 4)
  %82 = getelementptr i64, ptr %heap_to_ptr42, i64 3
  %83 = load i64, ptr %82, align 4
  %84 = mul i64 %69, 2
  %85 = add i64 %83, %84
  store i64 %85, ptr %82, align 4
  %86 = getelementptr i64, ptr %heap_to_ptr42, i64 3
  %slot_value43 = load i64, ptr %86, align 4
  %87 = add i64 %slot_value43, 1
  %88 = call i64 @vector_new(i64 4)
  %heap_start44 = sub i64 %88, 4
  %heap_to_ptr45 = inttoptr i64 %heap_start44 to ptr
  %89 = call i64 @vector_new(i64 4)
  %heap_start46 = sub i64 %89, 4
  %heap_to_ptr47 = inttoptr i64 %heap_start46 to ptr
  store i64 %87, ptr %heap_to_ptr47, align 4
  %90 = getelementptr i64, ptr %heap_to_ptr47, i64 1
  store i64 0, ptr %90, align 4
  %91 = getelementptr i64, ptr %heap_to_ptr47, i64 2
  store i64 0, ptr %91, align 4
  %92 = getelementptr i64, ptr %heap_to_ptr47, i64 3
  store i64 0, ptr %92, align 4
  call void @get_storage(ptr %heap_to_ptr47, ptr %heap_to_ptr45)
  %storage_value48 = load i64, ptr %heap_to_ptr45, align 4
  %93 = add i64 %storage_value48, 1
  call void @builtin_range_check(i64 %93)
  %94 = call i64 @vector_new(i64 4)
  %heap_start49 = sub i64 %94, 4
  %heap_to_ptr50 = inttoptr i64 %heap_start49 to ptr
  store i64 %68, ptr %heap_to_ptr50, align 4
  %95 = getelementptr i64, ptr %heap_to_ptr50, i64 1
  store i64 0, ptr %95, align 4
  %96 = getelementptr i64, ptr %heap_to_ptr50, i64 2
  store i64 0, ptr %96, align 4
  %97 = getelementptr i64, ptr %heap_to_ptr50, i64 3
  store i64 0, ptr %97, align 4
  %98 = call i64 @vector_new(i64 4)
  %heap_start51 = sub i64 %98, 4
  %heap_to_ptr52 = inttoptr i64 %heap_start51 to ptr
  store i64 %93, ptr %heap_to_ptr52, align 4
  %99 = getelementptr i64, ptr %heap_to_ptr52, i64 1
  store i64 0, ptr %99, align 4
  %100 = getelementptr i64, ptr %heap_to_ptr52, i64 2
  store i64 0, ptr %100, align 4
  %101 = getelementptr i64, ptr %heap_to_ptr52, i64 3
  store i64 0, ptr %101, align 4
  call void @set_storage(ptr %heap_to_ptr50, ptr %heap_to_ptr52)
  ret void
}

define ptr @get_caller() {
entry:
  %0 = call i64 @vector_new(i64 4)
  %heap_start = sub i64 %0, 4
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %index_access = getelementptr i64, ptr %heap_to_ptr, i64 0
  store i64 402443140940559753, ptr %index_access, align 4
  %index_access1 = getelementptr i64, ptr %heap_to_ptr, i64 1
  store i64 -5438528055523826848, ptr %index_access1, align 4
  %index_access2 = getelementptr i64, ptr %heap_to_ptr, i64 2
  store i64 6500940582073311439, ptr %index_access2, align 4
  %index_access3 = getelementptr i64, ptr %heap_to_ptr, i64 3
  store i64 -6711892513312253938, ptr %index_access3, align 4
  ret ptr %heap_to_ptr
}

define void @vote_test() {
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
  store i64 65, ptr %index_access2, align 4
  %length3 = load i64, ptr %heap_to_ptr, align 4
  %7 = sub i64 %length3, 1
  %8 = sub i64 %7, 1
  call void @builtin_range_check(i64 %8)
  %9 = ptrtoint ptr %heap_to_ptr to i64
  %10 = add i64 %9, 1
  %vector_data4 = inttoptr i64 %10 to ptr
  %index_access5 = getelementptr i64, ptr %vector_data4, i64 1
  store i64 66, ptr %index_access5, align 4
  %length6 = load i64, ptr %heap_to_ptr, align 4
  %11 = sub i64 %length6, 1
  %12 = sub i64 %11, 2
  call void @builtin_range_check(i64 %12)
  %13 = ptrtoint ptr %heap_to_ptr to i64
  %14 = add i64 %13, 1
  %vector_data7 = inttoptr i64 %14 to ptr
  %index_access8 = getelementptr i64, ptr %vector_data7, i64 2
  store i64 67, ptr %index_access8, align 4
  call void @contract_init(ptr %heap_to_ptr)
  call void @vote_proposal(i64 1)
  %15 = call i64 @vector_new(i64 4)
  %heap_start9 = sub i64 %15, 4
  %heap_to_ptr10 = inttoptr i64 %heap_start9 to ptr
  %16 = call i64 @vector_new(i64 4)
  %heap_start11 = sub i64 %16, 4
  %heap_to_ptr12 = inttoptr i64 %heap_start11 to ptr
  store i64 1, ptr %heap_to_ptr12, align 4
  %17 = getelementptr i64, ptr %heap_to_ptr12, i64 1
  store i64 0, ptr %17, align 4
  %18 = getelementptr i64, ptr %heap_to_ptr12, i64 2
  store i64 0, ptr %18, align 4
  %19 = getelementptr i64, ptr %heap_to_ptr12, i64 3
  store i64 0, ptr %19, align 4
  call void @get_storage(ptr %heap_to_ptr12, ptr %heap_to_ptr10)
  %storage_value = load i64, ptr %heap_to_ptr10, align 4
  %20 = sub i64 %storage_value, 1
  %21 = sub i64 %20, 1
  call void @builtin_range_check(i64 %21)
  %22 = call i64 @vector_new(i64 4)
  %heap_start13 = sub i64 %22, 4
  %heap_to_ptr14 = inttoptr i64 %heap_start13 to ptr
  store i64 1, ptr %heap_to_ptr14, align 4
  %23 = getelementptr i64, ptr %heap_to_ptr14, i64 1
  store i64 0, ptr %23, align 4
  %24 = getelementptr i64, ptr %heap_to_ptr14, i64 2
  store i64 0, ptr %24, align 4
  %25 = getelementptr i64, ptr %heap_to_ptr14, i64 3
  store i64 0, ptr %25, align 4
  %26 = call i64 @vector_new(i64 4)
  %heap_start15 = sub i64 %26, 4
  %heap_to_ptr16 = inttoptr i64 %heap_start15 to ptr
  call void @poseidon_hash(ptr %heap_to_ptr14, ptr %heap_to_ptr16, i64 4)
  %27 = getelementptr i64, ptr %heap_to_ptr16, i64 3
  %28 = load i64, ptr %27, align 4
  %29 = add i64 %28, 2
  store i64 %29, ptr %27, align 4
  %30 = getelementptr i64, ptr %heap_to_ptr16, i64 3
  %slot_value = load i64, ptr %30, align 4
  %31 = add i64 %slot_value, 1
  %32 = call i64 @vector_new(i64 4)
  %heap_start17 = sub i64 %32, 4
  %heap_to_ptr18 = inttoptr i64 %heap_start17 to ptr
  %33 = call i64 @vector_new(i64 4)
  %heap_start19 = sub i64 %33, 4
  %heap_to_ptr20 = inttoptr i64 %heap_start19 to ptr
  store i64 %31, ptr %heap_to_ptr20, align 4
  %34 = getelementptr i64, ptr %heap_to_ptr20, i64 1
  store i64 0, ptr %34, align 4
  %35 = getelementptr i64, ptr %heap_to_ptr20, i64 2
  store i64 0, ptr %35, align 4
  %36 = getelementptr i64, ptr %heap_to_ptr20, i64 3
  store i64 0, ptr %36, align 4
  call void @get_storage(ptr %heap_to_ptr20, ptr %heap_to_ptr18)
  %storage_value21 = load i64, ptr %heap_to_ptr18, align 4
  %37 = icmp eq i64 %storage_value21, 1
  %38 = zext i1 %37 to i64
  call void @builtin_assert(i64 %38)
  ret void
}

define void @function_dispatch(i64 %0, i64 %1, ptr %2) {
entry:
  %input_alloca = alloca ptr, align 8
  store ptr %2, ptr %input_alloca, align 8
  %input = load ptr, ptr %input_alloca, align 8
  switch i64 %0, label %missing_function [
    i64 2817135588, label %func_0_dispatch
    i64 3186728800, label %func_1_dispatch
    i64 363199787, label %func_2_dispatch
    i64 2791810083, label %func_3_dispatch
    i64 2868727644, label %func_4_dispatch
    i64 69185575, label %func_5_dispatch
  ]

missing_function:                                 ; preds = %entry
  unreachable

func_0_dispatch:                                  ; preds = %entry
  %input_start = ptrtoint ptr %input to i64
  %3 = inttoptr i64 %input_start to ptr
  %length = load i64, ptr %3, align 4
  %4 = mul i64 %length, 1
  %5 = add i64 %4, 1
  call void @contract_init(ptr %3)
  ret void

func_1_dispatch:                                  ; preds = %entry
  %6 = call i64 @winningProposal()
  %7 = call i64 @vector_new(i64 2)
  %heap_start = sub i64 %7, 2
  %heap_to_ptr = inttoptr i64 %heap_start to ptr
  %encode_value_ptr = getelementptr i64, ptr %heap_to_ptr, i64 0
  store i64 %6, ptr %encode_value_ptr, align 4
  %encode_value_ptr1 = getelementptr i64, ptr %heap_to_ptr, i64 1
  store i64 1, ptr %encode_value_ptr1, align 4
  call void @set_tape_data(i64 %heap_start, i64 2)
  ret void

func_2_dispatch:                                  ; preds = %entry
  %8 = call i64 @getWinnerName()
  %9 = call i64 @vector_new(i64 2)
  %heap_start2 = sub i64 %9, 2
  %heap_to_ptr3 = inttoptr i64 %heap_start2 to ptr
  %encode_value_ptr4 = getelementptr i64, ptr %heap_to_ptr3, i64 0
  store i64 %8, ptr %encode_value_ptr4, align 4
  %encode_value_ptr5 = getelementptr i64, ptr %heap_to_ptr3, i64 1
  store i64 1, ptr %encode_value_ptr5, align 4
  call void @set_tape_data(i64 %heap_start2, i64 2)
  ret void

func_3_dispatch:                                  ; preds = %entry
  %input_start6 = ptrtoint ptr %input to i64
  %10 = inttoptr i64 %input_start6 to ptr
  %decode_value = load i64, ptr %10, align 4
  call void @vote_proposal(i64 %decode_value)
  ret void

func_4_dispatch:                                  ; preds = %entry
  %11 = call ptr @get_caller()
  %12 = call i64 @vector_new(i64 5)
  %heap_start7 = sub i64 %12, 5
  %heap_to_ptr8 = inttoptr i64 %heap_start7 to ptr
  %13 = getelementptr i64, ptr %11, i64 0
  %14 = load i64, ptr %13, align 4
  %encode_value_ptr9 = getelementptr i64, ptr %heap_to_ptr8, i64 0
  store i64 %14, ptr %encode_value_ptr9, align 4
  %15 = getelementptr i64, ptr %11, i64 1
  %16 = load i64, ptr %15, align 4
  %encode_value_ptr10 = getelementptr i64, ptr %heap_to_ptr8, i64 1
  store i64 %16, ptr %encode_value_ptr10, align 4
  %17 = getelementptr i64, ptr %11, i64 2
  %18 = load i64, ptr %17, align 4
  %encode_value_ptr11 = getelementptr i64, ptr %heap_to_ptr8, i64 2
  store i64 %18, ptr %encode_value_ptr11, align 4
  %19 = getelementptr i64, ptr %11, i64 3
  %20 = load i64, ptr %19, align 4
  %encode_value_ptr12 = getelementptr i64, ptr %heap_to_ptr8, i64 3
  store i64 %20, ptr %encode_value_ptr12, align 4
  %encode_value_ptr13 = getelementptr i64, ptr %heap_to_ptr8, i64 4
  store i64 4, ptr %encode_value_ptr13, align 4
  call void @set_tape_data(i64 %heap_start7, i64 5)
  ret void

func_5_dispatch:                                  ; preds = %entry
  call void @vote_test()
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
