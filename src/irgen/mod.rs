pub mod address_or_hash_op;
pub mod binary;
mod corelib;
mod dispatch;
mod encoding;
pub mod expression;
mod functions;
mod statements;
pub mod storage;
mod strings;
pub mod u32_op;
mod unused_variable;

#[macro_export]
macro_rules! emit_context {
    ($binary:expr) => {
        #[allow(unused_macros)]
        macro_rules! i64_const {
            ($val:expr) => {
                $binary.context.i64_type().const_int($val, false)
            };
        }

        #[allow(unused_macros)]
        macro_rules! i64_zero {
            () => {
                $binary.context.i64_type().const_zero()
            };
        }

        #[allow(unused_macros)]
        macro_rules! call {
            ($name:expr, $args:expr) => {
                $binary
                    .builder
                    .build_call($binary.module.get_function($name).unwrap(), $args, "")
            };

            ($name:expr, $args:expr, $call_name:literal) => {
                $binary.builder.build_call(
                    $binary.module.get_function($name).unwrap(),
                    $args,
                    $call_name,
                )
            };
        }
    };
}

// impl ast::Contract {
//     /// Generate the binary. This can be used to generate llvm text, object
// file     /// or final linked binary.
//     pub fn generate_llvm_ir<'a>(
//         &'a self,
//         ns: &'a ast::Namespace,
//         context: &'a inkwell::context::Context,
//         filename: &'a str,
//     ) -> binary::Binary { binary::Binary::build(context, self, ns, filename)
//     }
// }
