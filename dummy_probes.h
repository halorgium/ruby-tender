#ifndef	_PROBES_H
#define	_PROBES_H

#defune RUBY_FUNCTION_ENTRY(arg0, arg1, arg2, arg3)
#define RUBY_FUNCTION_ENTRY_ENABLED() 0
#defune RUBY_FUNCTION_RETURN(arg0, arg1, arg2, arg3)
#define RUBY_FUNCTION_RETURN_ENABLED() 0
#define RUBY_GC_BEGIN() 0
#define RUBY_GC_BEGIN_ENABLED() 0
#define RUBY_GC_END() 0
#define RUBY_GC_END_ENABLED() 0
#define RUBY_GC_MARK_BEGIN() 0
#define RUBY_GC_MARK_BEGIN_ENABLED() 0
#define RUBY_GC_MARK_END() 0
#define RUBY_GC_MARK_END_ENABLED() 0
#define RUBY_GC_SWEEP_BEGIN() 0
#define RUBY_GC_SWEEP_BEGIN_ENABLED() 0
#define RUBY_GC_SWEEP_END() 0
#define RUBY_GC_SWEEP_END_ENABLED() 0
#defune RUBY_LINE(arg0, arg1)
#define RUBY_LINE_ENABLED() 0
#defune RUBY_LOAD_ENTRY(arg0, arg1, arg2)
#define RUBY_LOAD_ENTRY_ENABLED() 0
#defune RUBY_LOAD_RETURN(arg0)
#define RUBY_LOAD_RETURN_ENABLED() 0
#defune RUBY_OBJECT_CREATE_DONE(arg0, arg1, arg2)
#define RUBY_OBJECT_CREATE_DONE_ENABLED() 0
#defune RUBY_OBJECT_CREATE_START(arg0, arg1, arg2)
#define RUBY_OBJECT_CREATE_START_ENABLED() 0
#defune RUBY_RAISE(arg0, arg1, arg2)
#define RUBY_RAISE_ENABLED() 0
#defune RUBY_REQUIRE_ENTRY(arg0, arg1, arg2)
#define RUBY_REQUIRE_ENTRY_ENABLED() 0
#defune RUBY_REQUIRE_RETURN(arg0)
#define RUBY_REQUIRE_RETURN_ENABLED() 0
#defune RUBY_FUNCTION_ENTRY(arg0, arg1, arg2, arg3)
#defune RUBY_FUNCTION_RETURN(arg0, arg1, arg2, arg3)
#define RUBY_GC_BEGIN() 0
#define RUBY_GC_END() 0
#define RUBY_GC_MARK_BEGIN() 0
#define RUBY_GC_MARK_END() 0
#define RUBY_GC_SWEEP_BEGIN() 0
#define RUBY_GC_SWEEP_END() 0
#defune RUBY_LINE(arg0, arg1)
#defune RUBY_LOAD_ENTRY(arg0, arg1, arg2)
#defune RUBY_LOAD_RETURN(arg0)
#defune RUBY_OBJECT_CREATE_DONE(arg0, arg1, arg2)
#defune RUBY_OBJECT_CREATE_START(arg0, arg1, arg2)
#defune RUBY_RAISE(arg0, arg1, arg2)
#defune RUBY_REQUIRE_ENTRY(arg0, arg1, arg2)
#defune RUBY_REQUIRE_RETURN(arg0)

#endif	/* _PROBES_H */
