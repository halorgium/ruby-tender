#include <fiddle.h>

VALUE cFiddleFunction;

static void
deallocate(void *p)
{
    ffi_cif *ptr = p;
    if (ptr->arg_types) xfree(ptr->arg_types);
    xfree(ptr);
}

static size_t
function_memsize(const void *p)
{
    /* const */ffi_cif *ptr = (ffi_cif *)p;
    size_t size = 0;

    if (ptr) {
	size += sizeof(*ptr);
#if !defined(FFI_NO_RAW_API) || !FFI_NO_RAW_API
	size += ffi_raw_size(ptr);
#endif
    }
    return size;
}

const rb_data_type_t function_data_type = {
    "fiddle/function",
    0, deallocate, function_memsize,
};

static VALUE
allocate(VALUE klass)
{
    ffi_cif * cif;

    return TypedData_Make_Struct(klass, ffi_cif, &function_data_type, cif);
}

static VALUE
initialize(int argc, VALUE argv[], VALUE self)
{
    ffi_cif * cif;
    ffi_type **arg_types;
    ffi_status result;
    VALUE ptr, args, ret_type, abi;
    int i;

    rb_scan_args(argc, argv, "31", &ptr, &args, &ret_type, &abi);
    if(NIL_P(abi)) abi = INT2NUM(FFI_DEFAULT_ABI);

    Check_Type(args, T_ARRAY);

    rb_iv_set(self, "@ptr", ptr);
    rb_iv_set(self, "@args", args);
    rb_iv_set(self, "@return_type", ret_type);
    rb_iv_set(self, "@abi", abi);

    TypedData_Get_Struct(self, ffi_cif, &function_data_type, cif);

    arg_types = xcalloc(RARRAY_LEN(args) + 1, sizeof(ffi_type *));

    for (i = 0; i < RARRAY_LEN(args); i++) {
	int type = NUM2INT(RARRAY_PTR(args)[i]);
	arg_types[i] = INT2FFI_TYPE(type);
    }
    arg_types[RARRAY_LEN(args)] = NULL;

    result = ffi_prep_cif (
	    cif,
	    NUM2INT(abi),
	    RARRAY_LENINT(args),
	    INT2FFI_TYPE(NUM2INT(ret_type)),
	    arg_types);

    if (result)
	rb_raise(rb_eRuntimeError, "error creating CIF %d", result);

    return self;
}

static VALUE
function_call(int argc, VALUE argv[], VALUE self)
{
    ffi_cif * cif;
    fiddle_generic retval;
    fiddle_generic *generic_args;
    void **values;
    void * fun_ptr;
    VALUE cfunc, types;
    int i;

    TypedData_Get_Struct(self, ffi_cif, &function_data_type, cif);

    values = xcalloc((size_t)argc + 1, (size_t)sizeof(void *));
    generic_args = xcalloc((size_t)argc, (size_t)sizeof(fiddle_generic));

    cfunc = rb_iv_get(self, "@ptr");
    types = rb_iv_get(self, "@args");

    for (i = 0; i < argc; i++) {
	VALUE type = RARRAY_PTR(types)[i];
	VALUE src = argv[i];

	if(NUM2INT(type) == TYPE_VOIDP) {
#if 0
	    if(NIL_P(src)) {
		src = INT2NUM(0);
	    } else if(rb_cDLCPtr != CLASS_OF(src)) {
	        src = rb_funcall(rb_cDLCPtr, rb_intern("[]"), 1, src);
	    }
#endif
	    src = rb_Integer(src);
	}

	VALUE2GENERIC(NUM2INT(type), src, &generic_args[i]);
	values[i] = (void *)&generic_args[i];
    }
    values[argc] = NULL;

    ffi_call(cif, NUM2PTR(rb_Integer(cfunc)), &retval, values);

#if 0
    rb_dl_set_last_error(self, INT2NUM(errno));
#if defined(HAVE_WINDOWS_H)
    rb_dl_set_win32_last_error(self, INT2NUM(GetLastError()));
#endif
#endif

    xfree(values);
    xfree(generic_args);

    return GENERIC2VALUE(rb_iv_get(self, "@return_type"), retval);
}

void
Init_fiddle_function(void)
{
    cFiddleFunction = rb_define_class_under(mFiddle, "Function", rb_cObject);

    rb_define_const(cFiddleFunction, "DEFAULT", INT2NUM(FFI_DEFAULT_ABI));

#ifdef FFI_STDCALL
    rb_define_const(cFiddleFunction, "STDCALL", INT2NUM(FFI_STDCALL));
#endif

    rb_define_alloc_func(cFiddleFunction, allocate);

    rb_define_method(cFiddleFunction, "call", function_call, -1);
    rb_define_method(cFiddleFunction, "initialize", initialize, -1);
}
/* vim: set noet sw=4 sts=4 */
