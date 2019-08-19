#include "enum.h"
#if !__USE_MINGW_ANSI_STDIO && (defined(__MINGW32__) || defined(__MINGW64__))
#define __USE_MINGW_ANSI_STDIO 1
#endif

#include <stdio.h>
#include <stddef.h>
#include "ctypes_cstubs_internals.h"

int main(void)
{

  puts("include Ctypes");
  puts("let lift x = x");
  puts("open Ctypes_static");
  puts("");
  puts("let rec field : type t a. t typ -> string -> a typ -> (a, t) field =");
  puts("  fun s fname ftype -> match s, fname with");
  puts("  | View { ty }, _ ->");
  puts("    let { ftype; foffset; fname } = field ty fname ftype in");
  puts("    { ftype; foffset; fname }");
  puts("  | _ -> failwith (\"Unexpected field \"^ fname)");
  puts("");
  puts("let rec seal : type a. a typ -> unit = function");
  puts("  | Struct { tag; spec = Complete _ } ->");
  puts("    raise (ModifyingSealedType tag)");
  puts("  | Union { utag; uspec = Some _ } ->");
  puts("    raise (ModifyingSealedType utag)");
  puts("  | View { ty } -> seal ty");
  puts("  | _ ->");
  puts("    raise (Unsupported \"Sealing a non-structured type\")");
  puts("");
  puts("type 'a const = 'a");
  puts("let constant (type t) name (t : t typ) : t = match t, name with");
  {
     enum { check_C_const = (int)C };
     int64_t v = (C);
     printf("  | Ctypes_static.Primitive Cstubs_internals.Int64_t, \"C\" ->\n    %ldL\n",
           v);
     
  }
  {
     enum { check_B_const = (int)B };
     int64_t v = (B);
     printf("  | Ctypes_static.Primitive Cstubs_internals.Int64_t, \"B\" ->\n    %ldL\n",
           v);
     
  }
  {
     enum { check_A_const = (int)A };
     int64_t v = (A);
     printf("  | Ctypes_static.Primitive Cstubs_internals.Int64_t, \"A\" ->\n    %ldL\n",
           v);
     
  }
  puts("  | _, s -> failwith (\"unmatched constant: \"^ s)");
  puts("");
  puts("let enum (type a) name ?typedef ?unexpected (alist : (a * int64) list) =");
  puts("  match name with");
  printf("  | \"letter\" -> \n    Cstubs_internals.build_enum_type \"letter\" Ctypes_static.%s ?typedef ?unexpected alist\n",
        ctypes_arithmetic_type_name(CTYPES_CLASSIFY_ARITHMETIC_TYPE(enum letter)));
  puts("  | s ->");
  puts("    failwith (\"unmatched enum: \"^ s)");
  
  return 0;
}
