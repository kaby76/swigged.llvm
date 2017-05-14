	TAGS	UNSORTED
__STDC_LIMIT_MACROS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	717	#define __STDC_LIMIT_MACROS
__STDC_CONSTANT_MACROS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	783	#define __STDC_CONSTANT_MACROS
bzero	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1081	void bzero (void *to, size_t count) { memset (to, 0, count); }
ALIGN_PTR_TO	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1250	#define ALIGN_PTR_TO(ptr,align) (gpointer)((((gssize)(ptr)) + (align - 1)) & (~(align - 1)))
lmodule	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1431		LLVMModuleRef lmodule;
throw_icall	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1454		LLVMValueRef throw_icall, rethrow, match_exc, throw_corlib_exception, resume_eh;
rethrow	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1467		LLVMValueRef throw_icall, rethrow, match_exc, throw_corlib_exception, resume_eh;
match_exc	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1476		LLVMValueRef throw_icall, rethrow, match_exc, throw_corlib_exception, resume_eh;
throw_corlib_exception	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1487		LLVMValueRef throw_icall, rethrow, match_exc, throw_corlib_exception, resume_eh;
resume_eh	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1511		LLVMValueRef throw_icall, rethrow, match_exc, throw_corlib_exception, resume_eh;
llvm_types	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1535		GHashTable *llvm_types;
got_var	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1561		LLVMValueRef got_var;
got_symbol	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1583		const char *got_symbol;
get_method_symbol	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1608		const char *get_method_symbol;
get_unbox_tramp_symbol	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1640		const char *get_unbox_tramp_symbol;
plt_entries	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1677		GHashTable *plt_entries;
plt_entries_ji	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1703		GHashTable *plt_entries_ji;
method_to_lmethod	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1732		GHashTable *method_to_lmethod;
direct_callables	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1764		GHashTable *direct_callables;
bb_names	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1790		char **bb_names;
bb_names_len	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1805		int bb_names_len;
used	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1831		GPtrArray *used;
ptr_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1850		LLVMTypeRef ptr_type;
subprogram_mds	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1872		GPtrArray *subprogram_mds;
mono_ee	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1900		MonoEERef *mono_ee;
ee	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1933		LLVMExecutionEngineRef ee;
external_symbols	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1947		gboolean external_symbols;
emit_dwarf	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1975		gboolean emit_dwarf;
max_got_offset	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	1992		int max_got_offset;
personality	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2022		LLVMValueRef personality;
assembly	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2066		MonoAssembly *assembly;
global_prefix	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2083		char *global_prefix;
aot_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2115		MonoAotFileInfo aot_info;
jit_got_symbol	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2138		const char *jit_got_symbol;
eh_frame_symbol	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2167		const char *eh_frame_symbol;
get_method	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2198		LLVMValueRef get_method, get_unbox_tramp;
get_unbox_tramp	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2210		LLVMValueRef get_method, get_unbox_tramp;
init_method	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2241		LLVMValueRef init_method, init_method_gshared_mrgctx, init_method_gshared_this, init_method_gshared_vtable;
init_method_gshared_mrgctx	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2254		LLVMValueRef init_method, init_method_gshared_mrgctx, init_method_gshared_this, init_method_gshared_vtable;
init_method_gshared_this	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2282		LLVMValueRef init_method, init_method_gshared_mrgctx, init_method_gshared_this, init_method_gshared_vtable;
init_method_gshared_vtable	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2308		LLVMValueRef init_method, init_method_gshared_mrgctx, init_method_gshared_this, init_method_gshared_vtable;
code_start	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2350		LLVMValueRef code_start, code_end;
code_end	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2362		LLVMValueRef code_start, code_end;
inited_var	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2386		LLVMValueRef inited_var;
max_inited_idx	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2403		int max_inited_idx, max_method_idx;
max_method_idx	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2419		int max_inited_idx, max_method_idx;
has_jitted_code	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2445		gboolean has_jitted_code;
static_link	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2472		gboolean static_link;
llvm_only	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2495		gboolean llvm_only;
idx_to_lmethod	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2519		GHashTable *idx_to_lmethod;
idx_to_unbox_tramp	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2548		GHashTable *idx_to_unbox_tramp;
method_to_callers	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2643		GHashTable *method_to_callers;
context	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2678		LLVMContextRef context;
sentinel_exception	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2701		LLVMValueRef sentinel_exception;
di_builder	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2728		void *di_builder, *cu;
cu	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2741		void *di_builder, *cu;
objc_selector_to_var	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2758		GHashTable *objc_selector_to_var;
MonoLLVMModule	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2782	} MonoLLVMModule;
bblock	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2907		LLVMBasicBlockRef bblock, end_bblock;
end_bblock	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2915		LLVMBasicBlockRef bblock, end_bblock;
finally_ind	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2941		LLVMValueRef finally_ind;
added	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2964		gboolean added, invoke_target;
invoke_target	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	2971		gboolean added, invoke_target;
call_handler_return_bbs	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3125		GSList *call_handler_return_bbs;
call_handler_target_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3292		LLVMBasicBlockRef call_handler_target_bb;
endfinally_switch_ins_list	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3399		GSList *endfinally_switch_ins_list;
phi_nodes	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3436		GSList *phi_nodes;
BBInfo	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3449	} BBInfo;
mempool	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3531		MonoMemPool *mempool;
emitted_method_decls	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3613		GHashTable *emitted_method_decls;
cfg	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3650		MonoCompile *cfg;
lmethod	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3669		LLVMValueRef lmethod;
module	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3695		MonoLLVMModule *module;
lmodule	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3718		LLVMModuleRef lmodule;
bblocks	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3736		BBInfo *bblocks;
sindex	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3750		int sindex, default_index, ex_index;
default_index	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3758		int sindex, default_index, ex_index;
ex_index	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3773		int sindex, default_index, ex_index;
builder	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3799		LLVMBuilderRef builder;
values	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3823		LLVMValueRef *values, *addresses;
addresses	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3832		LLVMValueRef *values, *addresses;
vreg_cli_types	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3855		MonoType **vreg_cli_types;
linfo	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3886		LLVMCallInfo *linfo;
sig	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3915		MonoMethodSignature *sig;
builders	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3929		GSList *builders;
region_to_handler	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3952		GHashTable *region_to_handler;
clause_to_handler	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	3984		GHashTable *clause_to_handler;
alloca_builder	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4019		LLVMBuilderRef alloca_builder;
last_alloca	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4049		LLVMValueRef last_alloca;
rgctx_arg	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4076		LLVMValueRef rgctx_arg;
this_arg	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4101		LLVMValueRef this_arg;
vreg_types	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4125		LLVMTypeRef *vreg_types;
is_vphi	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4148		gboolean *is_vphi;
method_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4170		LLVMTypeRef method_type;
init_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4202		LLVMBasicBlockRef init_bb, inited_bb;
inited_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4211		LLVMBasicBlockRef init_bb, inited_bb;
is_dead	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4233		gboolean *is_dead;
unreachable	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4253		gboolean *unreachable;
llvm_only	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4276		gboolean llvm_only;
has_got_access	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4297		gboolean has_got_access;
is_linkonce	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4323		gboolean is_linkonce;
this_arg_pindex	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4341		int this_arg_pindex, rgctx_arg_pindex;
rgctx_arg_pindex	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4358		int this_arg_pindex, rgctx_arg_pindex;
imt_rgctx_loc	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4390		LLVMValueRef imt_rgctx_loc;
llvm_types	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4418		GHashTable *llvm_types;
dbg_md	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4444		LLVMValueRef dbg_md;
minfo	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4474		MonoDebugMethodInfo *minfo;
temp_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4487		char temp_name [32];
nested_in	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4566		GSList **nested_in;
ex_var	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4591		LLVMValueRef ex_var;
exc_meta	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4612		GHashTable *exc_meta;
method_to_callers	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4635		GHashTable *method_to_callers;
phi_values	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4666		GPtrArray *phi_values;
bblock_list	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4690		GPtrArray *bblock_list;
method_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4710		char *method_name;
jit_callees	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4736		GHashTable *jit_callees;
long_bb_break_var	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4763		LLVMValueRef long_bb_break_var;
EmitContext	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4784	} EmitContext;
bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4832		MonoBasicBlock *bb;
phi	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4847		MonoInst *phi;
in_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4869		MonoBasicBlock *in_bb;
sreg	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4881		int sreg;
PhiNode	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	4889	} PhiNode;
MINI_OP	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5065	#define MINI_OP(a,b,dest,src1,src2) dest, src1, src2, ' ',
MINI_OP3	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5124	#define MINI_OP3(a,b,dest,src1,src2,src3) dest, src1, src2, src3,
NONE	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5190	#define NONE ' '
IREG	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5207	#define IREG 'i'
FREG	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5224	#define FREG 'f'
VREG	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5241	#define VREG 'v'
XREG	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5258	#define XREG 'x'
LREG	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5275	#define LREG 'l'
llvm_ins_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5338	llvm_ins_info[] = {
GET_LONG_IMM	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5446	#define GET_LONG_IMM(ins) (((guint64)(ins)->inst_ms_word << 32) | (guint64)(guint32)(ins)->inst_ls_word)
GET_LONG_IMM	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5557	#define GET_LONG_IMM(ins) ((ins)->inst_imm)
LLVM_INS_INFO	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5609	#define LLVM_INS_INFO(opcode) (&llvm_ins_info [((opcode) - OP_START - 1) * 4])
TRACE_FAILURE	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5767	#define TRACE_FAILURE(msg)
IS_TARGET_X86	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5820	#define IS_TARGET_X86 1
IS_TARGET_X86	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5850	#define IS_TARGET_X86 0
IS_TARGET_AMD64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5902	#define IS_TARGET_AMD64 1
IS_TARGET_AMD64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5934	#define IS_TARGET_AMD64 0
ctx_ok	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	5968	#define ctx_ok(ctx) (!(ctx)->cfg->disable_llvm)
cond_to_llvm_cond	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6033	static LLVMIntPredicate cond_to_llvm_cond [] = {
fpcond_to_llvm_cond	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6215	static LLVMRealPredicate fpcond_to_llvm_cond [] = {
current_cfg_tls_id	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6410	static MonoNativeTlsKey current_cfg_tls_id;
aot_module	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6453	static MonoLLVMModule aot_module;
intrins_id_to_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6485	static GHashTable *intrins_id_to_name;
intrins_name_to_id	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	6524	static GHashTable *intrins_name_to_id;
set_failure	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	7190	set_failure (EmitContext *ctx, const char *message)
IntPtrType	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	7450	IntPtrType (void)
ObjRefType	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	7562	ObjRefType (void)
ThisType	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	7716	ThisType (void)
get_vtype_size	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	7957	get_vtype_size (MonoType *t)
simd_class_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	8366	simd_class_to_llvm_type (EmitContext *ctx, MonoClass *klass)
type_to_simd_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	10616	type_to_simd_type (int type)
create_llvm_type_for_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	11144	create_llvm_type_for_type (MonoLLVMModule *module, MonoClass *klass)
type_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	12185	type_to_llvm_type (EmitContext *ctx, MonoType *t)
type_is_unsigned	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	13982	type_is_unsigned (EmitContext *ctx, MonoType *t)
type_to_llvm_arg_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	14380	type_to_llvm_arg_type (EmitContext *ctx, MonoType *t)
llvm_type_to_stack_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	15077	llvm_type_to_stack_type (MonoCompile *cfg, LLVMTypeRef type)
regtype_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	15545	regtype_to_llvm_type (char c)
op_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	15861	op_to_llvm_type (int opcode)
CLAUSE_START	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	17433	#define CLAUSE_START(clause) ((clause)->try_offset)
CLAUSE_END	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	17485	#define CLAUSE_END(clause) (((clause))->try_offset + ((clause))->try_len)
load_store_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	17700	load_store_to_llvm_type (int opcode, int *size, gboolean *sext, gboolean *zext)
ovf_op_to_intrins	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	19694	ovf_op_to_intrins (int opcode)
simd_op_to_intrins	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	20549	simd_op_to_intrins (int opcode)
simd_op_to_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	23438	simd_op_to_llvm_type (int opcode)
get_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	24834	get_bb (EmitContext *ctx, MonoBasicBlock *bb)
get_end_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	26204	get_end_bb (EmitContext *ctx, MonoBasicBlock *bb)
gen_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	26352	gen_bb (EmitContext *ctx, const char *prefix)
resolve_patch	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	26644	resolve_patch (MonoCompile *cfg, MonoJumpInfoType type, gconstpointer target)
convert_full	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	27087	convert_full (EmitContext *ctx, LLVMValueRef v, LLVMTypeRef dtype, gboolean is_unsigned)
convert	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	29463	convert (EmitContext *ctx, LLVMValueRef v, LLVMTypeRef dtype)
emit_volatile_load	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	29684	emit_volatile_load (EmitContext *ctx, int vreg)
emit_volatile_store	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	30972	emit_volatile_store (EmitContext *ctx, int vreg)
sig_to_llvm_sig_no_cinfo	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	31338	sig_to_llvm_sig_no_cinfo (EmitContext *ctx, MonoMethodSignature *sig)
sig_to_llvm_sig_full	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	32301	sig_to_llvm_sig_full (EmitContext *ctx, MonoMethodSignature *sig, LLVMCallInfo *cinfo)
sig_to_llvm_sig	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	39027	sig_to_llvm_sig (EmitContext *ctx, MonoMethodSignature *sig)
LLVMFunctionType0	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	39259	LLVMFunctionType0 (LLVMTypeRef ReturnType,
LLVMFunctionType1	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	39506	LLVMFunctionType1 (LLVMTypeRef ReturnType,
LLVMFunctionType2	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	39853	LLVMFunctionType2 (LLVMTypeRef ReturnType,
LLVMFunctionType3	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	40262	LLVMFunctionType3 (LLVMTypeRef ReturnType,
LLVMFunctionType5	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	40647	LLVMFunctionType5 (LLVMTypeRef ReturnType,
create_builder	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	41244	create_builder (EmitContext *ctx)
get_aotconst_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	41449	get_aotconst_name (MonoJumpInfoType type, gconstpointer data, int got_offset)
get_aotconst_typed	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	42013	get_aotconst_typed (EmitContext *ctx, MonoJumpInfoType type, gconstpointer data, LLVMTypeRef llvm_type)
get_aotconst	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	43486	get_aotconst (EmitContext *ctx, MonoJumpInfoType type, gconstpointer data)
get_callee	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	43638	get_callee (EmitContext *ctx, LLVMTypeRef llvm_sig, MonoJumpInfoType type, gconstpointer data)
emit_jit_callee	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	45453	emit_jit_callee (EmitContext *ctx, const char *name, LLVMTypeRef llvm_sig, gpointer target)
get_handler_clause	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	46119	get_handler_clause (MonoCompile *cfg, MonoBasicBlock *bb)
get_most_deep_clause	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	46647	get_most_deep_clause (MonoCompile *cfg, EmitContext *ctx, MonoBasicBlock *bb)
set_metadata_flag	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	47076	set_metadata_flag (LLVMValueRef v, const char *flag_name)
set_invariant_load_flag	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	47340	set_invariant_load_flag (LLVMValueRef v)
emit_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	47819	emit_call (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, LLVMValueRef callee, LLVMValueRef *args, int pindex)
emit_load_general	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	50212	emit_load_general (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, int size, LLVMValueRef addr, LLVMValueRef base, const char *name, gboolean is_faulting, BarrierKind barrier)
emit_load	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	53398	emit_load (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, int size, LLVMValueRef addr, const char *name, gboolean is_faulting)
emit_store_general	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	53668	emit_store_general (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, int size, LLVMValueRef value, LLVMValueRef addr, LLVMValueRef base, gboolean is_faulting, BarrierKind barrier)
emit_store	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	55967	emit_store (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, int size, LLVMValueRef value, LLVMValueRef addr, LLVMValueRef base, gboolean is_faulting)
emit_cond_system_exception	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	56405	emit_cond_system_exception (EmitContext *ctx, MonoBasicBlock *bb, const char *exc_type, LLVMValueRef cmp)
emit_args_to_vtype	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	60035	emit_args_to_vtype (EmitContext *ctx, LLVMBuilderRef builder, MonoType *t, LLVMValueRef address, LLVMArgInfo *ainfo, LLVMValueRef *args)
emit_vtype_to_args	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	62254	emit_vtype_to_args (EmitContext *ctx, LLVMBuilderRef builder, MonoType *t, LLVMValueRef address, LLVMArgInfo *ainfo, LLVMValueRef *args, guint32 *nargs)
build_alloca_llvm_type_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	64168	build_alloca_llvm_type_name (EmitContext *ctx, LLVMTypeRef t, int align, const char *name)
build_alloca_llvm_type	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	64640	build_alloca_llvm_type (EmitContext *ctx, LLVMTypeRef t, int align)
build_alloca	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	64790	build_alloca (EmitContext *ctx, MonoType *t)
emit_gsharedvt_ldaddr	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	65240	emit_gsharedvt_ldaddr (EmitContext *ctx, int vreg)
mark_as_used	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	66455	mark_as_used (MonoLLVMModule *module, LLVMValueRef global)
emit_llvm_used	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	66637	emit_llvm_used (MonoLLVMModule *module)
emit_get_method	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	67487	emit_get_method (MonoLLVMModule *module)
emit_get_unbox_tramp	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	70252	emit_get_unbox_tramp (MonoLLVMModule *module)
emit_llvm_code_start	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	72080	emit_llvm_code_start (MonoLLVMModule *module)
emit_init_icall_wrapper	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	72689	emit_init_icall_wrapper (MonoLLVMModule *module, const char *name, const char *icall_name, int subtype)
emit_init_icall_wrappers	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	75914	emit_init_icall_wrappers (MonoLLVMModule *module)
emit_llvm_code_end	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	76511	emit_llvm_code_end (MonoLLVMModule *module)
emit_div_check	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	77106	emit_div_check (EmitContext *ctx, LLVMBuilderRef builder, MonoBasicBlock *bb, MonoInst *ins, LLVMValueRef lhs, LLVMValueRef rhs)
emit_init_method	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	79129	emit_init_method (EmitContext *ctx)
emit_unbox_tramp	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	81734	emit_unbox_tramp (EmitContext *ctx, const char *method_name, LLVMTypeRef method_type, LLVMValueRef method, int method_index)
emit_entry_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	84263	emit_entry_bb (EmitContext *ctx, LLVMBuilderRef builder)
process_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	93577	process_call (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef *builder_ref, MonoInst *ins)
emit_llvmonly_throw	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	109846	emit_llvmonly_throw (EmitContext *ctx, MonoBasicBlock *bb, gboolean rethrow, LLVMValueRef exc)
emit_throw	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	110969	emit_throw (EmitContext *ctx, MonoBasicBlock *bb, gboolean rethrow, LLVMValueRef exc)
emit_resume_eh	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	112458	emit_resume_eh (EmitContext *ctx, MonoBasicBlock *bb)
mono_llvm_emit_clear_exception_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	113242	mono_llvm_emit_clear_exception_call (EmitContext *ctx, LLVMBuilderRef builder)
mono_llvm_emit_load_exception_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	113840	mono_llvm_emit_load_exception_call (EmitContext *ctx, LLVMBuilderRef builder)
mono_llvm_emit_match_exception_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	114443	mono_llvm_emit_match_exception_call (EmitContext *ctx, LLVMBuilderRef builder, gint32 region_start, gint32 region_end)
use_debug_personality	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	116422	static const gboolean use_debug_personality = TRUE;
default_personality_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	116471	static const char *default_personality_name = "mono_debug_personality";
use_debug_personality	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	116552	static const gboolean use_debug_personality = FALSE;
default_personality_name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	116602	static const char *default_personality_name = "__gxx_personality_v0";
default_cpp_lpad_exc_signature	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	116680	default_cpp_lpad_exc_signature (void)
get_mono_personality	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	117016	get_mono_personality (EmitContext *ctx)
emit_landing_pad	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	118090	emit_landing_pad (EmitContext *ctx, int group_index, int group_size)
emit_llvmonly_handler_start	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	121293	emit_llvmonly_handler_start (EmitContext *ctx, MonoBasicBlock *bb, LLVMBasicBlockRef cbb)
emit_handler_start	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	122476	emit_handler_start (EmitContext *ctx, MonoBasicBlock *bb, LLVMBuilderRef builder)
process_bb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	127776	process_bb (EmitContext *ctx, MonoBasicBlock *bb)
mono_llvm_check_method_supported	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	207145	mono_llvm_check_method_supported (MonoCompile *cfg)
get_llvm_call_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	208504	get_llvm_call_info (MonoCompile *cfg, MonoMethodSignature *sig)
free_ctx	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	210309	free_ctx (EmitContext *ctx)
mono_llvm_emit_method	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	211291	mono_llvm_emit_method (MonoCompile *cfg)
emit_method_inner	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	214939	emit_method_inner (EmitContext *ctx)
mono_llvm_create_vars	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	232599	mono_llvm_create_vars (MonoCompile *cfg)
mono_llvm_emit_call	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	233193	mono_llvm_emit_call (MonoCompile *cfg, MonoCallInst *call)
alloc_cb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	235327	alloc_cb (LLVMValueRef function, int size)
emitted_cb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	235671	emitted_cb (LLVMValueRef function, void *start, void *end)
exception_cb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	235901	exception_cb (void *data)
decode_llvm_eh_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	239290	decode_llvm_eh_info (EmitContext *ctx, gpointer eh_frame)
dlsym_cb	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	241407	dlsym_cb (const char *name, void **symbol)
AddFunc	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	241894	AddFunc (LLVMModuleRef module, const char *name, LLVMTypeRef ret_type, LLVMTypeRef *param_types, int nparams)
AddFunc2	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242119	AddFunc2 (LLVMModuleRef module, const char *name, LLVMTypeRef ret_type, LLVMTypeRef param_type1, LLVMTypeRef param_type2)
INTRINS_MEMSET	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242409		INTRINS_MEMSET,
INTRINS_MEMCPY	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242426		INTRINS_MEMCPY,
INTRINS_SADD_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242443		INTRINS_SADD_OVF_I32,
INTRINS_UADD_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242466		INTRINS_UADD_OVF_I32,
INTRINS_SSUB_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242489		INTRINS_SSUB_OVF_I32,
INTRINS_USUB_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242512		INTRINS_USUB_OVF_I32,
INTRINS_SMUL_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242535		INTRINS_SMUL_OVF_I32,
INTRINS_UMUL_OVF_I32	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242558		INTRINS_UMUL_OVF_I32,
INTRINS_SADD_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242581		INTRINS_SADD_OVF_I64,
INTRINS_UADD_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242604		INTRINS_UADD_OVF_I64,
INTRINS_SSUB_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242627		INTRINS_SSUB_OVF_I64,
INTRINS_USUB_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242650		INTRINS_USUB_OVF_I64,
INTRINS_SMUL_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242673		INTRINS_SMUL_OVF_I64,
INTRINS_UMUL_OVF_I64	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242696		INTRINS_UMUL_OVF_I64,
INTRINS_SIN	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242719		INTRINS_SIN,
INTRINS_COS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242733		INTRINS_COS,
INTRINS_SQRT	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242747		INTRINS_SQRT,
INTRINS_FABS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242762		INTRINS_FABS,
INTRINS_EXPECT_I8	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242777		INTRINS_EXPECT_I8,
INTRINS_EXPECT_I1	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242797		INTRINS_EXPECT_I1,
INTRINS_SSE_PMOVMSKB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242866		INTRINS_SSE_PMOVMSKB,
INTRINS_SSE_PSRLI_W	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242889		INTRINS_SSE_PSRLI_W,
INTRINS_SSE_PSRAI_W	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242911		INTRINS_SSE_PSRAI_W,
INTRINS_SSE_PSLLI_W	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242933		INTRINS_SSE_PSLLI_W,
INTRINS_SSE_PSRLI_D	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242955		INTRINS_SSE_PSRLI_D,
INTRINS_SSE_PSRAI_D	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242977		INTRINS_SSE_PSRAI_D,
INTRINS_SSE_PSLLI_D	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	242999		INTRINS_SSE_PSLLI_D,
INTRINS_SSE_PSRLI_Q	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243021		INTRINS_SSE_PSRLI_Q,
INTRINS_SSE_PSLLI_Q	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243043		INTRINS_SSE_PSLLI_Q,
INTRINS_SSE_SQRT_PD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243065		INTRINS_SSE_SQRT_PD,
INTRINS_SSE_SQRT_PS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243087		INTRINS_SSE_SQRT_PS,
INTRINS_SSE_RSQRT_PS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243109		INTRINS_SSE_RSQRT_PS,
INTRINS_SSE_RCP_PS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243132		INTRINS_SSE_RCP_PS,
INTRINS_SSE_CVTTPD2DQ	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243153		INTRINS_SSE_CVTTPD2DQ,
INTRINS_SSE_CVTTPS2DQ	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243177		INTRINS_SSE_CVTTPS2DQ,
INTRINS_SSE_CVTDQ2PD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243201		INTRINS_SSE_CVTDQ2PD,
INTRINS_SSE_CVTDQ2PS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243224		INTRINS_SSE_CVTDQ2PS,
INTRINS_SSE_CVTPD2DQ	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243247		INTRINS_SSE_CVTPD2DQ,
INTRINS_SSE_CVTPS2DQ	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243270		INTRINS_SSE_CVTPS2DQ,
INTRINS_SSE_CVTPD2PS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243293		INTRINS_SSE_CVTPD2PS,
INTRINS_SSE_CVTPS2PD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243316		INTRINS_SSE_CVTPS2PD,
INTRINS_SSE_CMPPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243339		INTRINS_SSE_CMPPD,
INTRINS_SSE_CMPPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243359		INTRINS_SSE_CMPPS,
INTRINS_SSE_PACKSSWB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243379		INTRINS_SSE_PACKSSWB,
INTRINS_SSE_PACKUSWB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243402		INTRINS_SSE_PACKUSWB,
INTRINS_SSE_PACKSSDW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243425		INTRINS_SSE_PACKSSDW,
INTRINS_SSE_PACKUSDW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243448		INTRINS_SSE_PACKUSDW,
INTRINS_SSE_MINPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243471		INTRINS_SSE_MINPS,
INTRINS_SSE_MAXPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243491		INTRINS_SSE_MAXPS,
INTRINS_SSE_HADDPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243511		INTRINS_SSE_HADDPS,
INTRINS_SSE_HSUBPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243532		INTRINS_SSE_HSUBPS,
INTRINS_SSE_ADDSUBPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243553		INTRINS_SSE_ADDSUBPS,
INTRINS_SSE_MINPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243576		INTRINS_SSE_MINPD,
INTRINS_SSE_MAXPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243596		INTRINS_SSE_MAXPD,
INTRINS_SSE_HADDPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243616		INTRINS_SSE_HADDPD,
INTRINS_SSE_HSUBPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243637		INTRINS_SSE_HSUBPD,
INTRINS_SSE_ADDSUBPD	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243658		INTRINS_SSE_ADDSUBPD,
INTRINS_SSE_PADDSW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243681		INTRINS_SSE_PADDSW,
INTRINS_SSE_PSUBSW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243702		INTRINS_SSE_PSUBSW,
INTRINS_SSE_PADDUSW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243723		INTRINS_SSE_PADDUSW,
INTRINS_SSE_PSUBUSW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243745		INTRINS_SSE_PSUBUSW,
INTRINS_SSE_PAVGW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243767		INTRINS_SSE_PAVGW,
INTRINS_SSE_PMULHW	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243787		INTRINS_SSE_PMULHW,
INTRINS_SSE_PMULHU	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243808		INTRINS_SSE_PMULHU,
INTRINS_SE_PADDSB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243829		INTRINS_SE_PADDSB,
INTRINS_SSE_PSUBSB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243849		INTRINS_SSE_PSUBSB,
INTRINS_SSE_PADDUSB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243870		INTRINS_SSE_PADDUSB,
INTRINS_SSE_PSUBUSB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243892		INTRINS_SSE_PSUBUSB,
INTRINS_SSE_PAVGB	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243914		INTRINS_SSE_PAVGB,
INTRINS_SSE_PAUSE	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243934		INTRINS_SSE_PAUSE,
INTRINS_SSE_DPPS	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243954		INTRINS_SSE_DPPS,
IntrinsicId	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	243994	} IntrinsicId;
id	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	244038		IntrinsicId id;
name	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	244055		const char *name;
IntrinsicDesc	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	244063	} IntrinsicDesc;
intrinsics	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	244100	static IntrinsicDesc intrinsics[] = {
add_sse_binary	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	247739	add_sse_binary (LLVMModuleRef module, const char *name, int type)
add_intrinsic	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	247928	add_intrinsic (LLVMModuleRef module, int id)
get_intrinsic	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	255390	get_intrinsic (EmitContext *ctx, const char *name)
add_intrinsics	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	256089	add_intrinsics (LLVMModuleRef module)
add_types	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	257320	add_types (MonoLLVMModule *module)
mono_llvm_init	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	257468	mono_llvm_init (void)
init_jit_module	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	257985	init_jit_module (MonoDomain *domain)
mono_llvm_cleanup	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	259098	mono_llvm_cleanup (void)
mono_llvm_free_domain_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	259297	mono_llvm_free_domain_info (MonoDomain *domain)
mono_llvm_create_aot_module	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	259839	mono_llvm_create_aot_module (MonoAssembly *assembly, const char *global_prefix, gboolean emit_dwarf, gboolean static_link, gboolean llvm_only)
llvm_array_from_uints	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	263679	llvm_array_from_uints (LLVMTypeRef el_type, guint32 *values, int nvalues)
llvm_array_from_bytes	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	264035	llvm_array_from_bytes (guint8 *values, int nvalues)
mono_llvm_emit_aot_file_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	264487	mono_llvm_emit_aot_file_info (MonoAotFileInfo *info, gboolean has_jitted_code)
mono_llvm_emit_aot_data	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	264847	mono_llvm_emit_aot_data (const char *symbol, guint8 *data, int data_len)
AddJitGlobal	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	265381	AddJitGlobal (MonoLLVMModule *module, LLVMTypeRef type, const char *name)
emit_aot_file_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	265642	emit_aot_file_info (MonoLLVMModule *module)
mono_llvm_emit_aot_module	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	273863	mono_llvm_emit_aot_module (const char *filename, const char *cu_name)
md_string	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	277323	md_string (const char *s)
emit_dbg_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	277429	emit_dbg_info (MonoLLVMModule *module, const char *filename, const char *cu_name)
emit_dbg_subprogram	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	281231	emit_dbg_subprogram (EmitContext *ctx, MonoCompile *cfg, LLVMValueRef method, const char *name)
emit_dbg_loc	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	284635	emit_dbg_loc (EmitContext *ctx, LLVMBuilderRef builder, const unsigned char *cil_code)
default_mono_llvm_unhandled_exception	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	285670	default_mono_llvm_unhandled_exception (void)
mono_llvm_cleanup	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	289571	mono_llvm_cleanup (void)
mono_llvm_free_domain_info	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	289606	mono_llvm_free_domain_info (MonoDomain *domain)
mono_llvm_init	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	289664	mono_llvm_init (void)
default_mono_llvm_unhandled_exception	c:\Users\Kenne\Documents\mono\mono\mini\mini-llvm.c	289696	default_mono_llvm_unhandled_exception (void)
