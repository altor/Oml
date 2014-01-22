#include<stdio.h>
#include<string.h>
#include<caml/mlvalues.h>
#include<caml/memory.h>

/* Prototypes */
int is_list(value entry);
int list_size_aux(value entry, int s);
int list_size(value entry);
void print_string(value string);
void print_int(value integer);
void print_double(value doublev);
void print_list(value list);
void print_nuplet(value nuplet);
void print_array(value array);
void print_cstm(int flag);
void print_unknown(void);
value polymorphic_print(value entry);
value polymorphic_length(value entry);

/* Affiche une entrée particulière */
void print_cstm(int flag){
  switch(flag){
  case 0  : printf("<Fun>");    return;
  case 1  : printf("<abstr>");  return;
  default : printf("<custom>"); return;
  }
}

/* Affiche une chaine de caractère */
void print_string(value string){
  CAMLparam1(string);
  printf("\"%s\"", String_val(string));
}

/* Affiche un entier */
void print_int(value integer){
  CAMLparam1(integer);
  printf("%d", Long_val(integer));
}

/* Affiche un entier */
void print_double(value doublev){
  CAMLparam1(doublev);
  printf("%g", Double_val(doublev));
}

/* Affiche une valeur inconnue */
void print_unknown(void){
  printf("?");
}

/* Affichage des listes */
void inner_list(value list){
  CAMLparam1(list);
  if(list == Val_emptylist) return;
  printf("; ");
  polymorphic_print(Field(list, 0));
  return inner_list(Field(list, 1));
}
void print_list(value list){
  CAMLparam1(list);
  printf("[");
  if(Wosize_val(list) > 0){
    polymorphic_print(Field(list, 0));
    inner_list(Field(list, 1));
  }
  printf("]");
}

/* Affiche un nuplet */
void print_nuplet(value nuplet){
  CAMLparam1(nuplet);
  int i;
  printf("(");
  if(Wosize_val(nuplet) > 0){
    polymorphic_print(Field(nuplet, 0));
    for(i = 1; i < Wosize_val(nuplet); i++){
      printf(", ");
      polymorphic_print(Field(nuplet, i));
    }
  }
  printf(")");
}

/* Affiche un tableau */
void print_array(value array){
  CAMLparam1(array);
  int i;
  int size = Wosize_val(array); 
  printf("[|");
  if (size > 0){
    printf("%g", Double_field(array, 0));
    for(i = 1; i < (size/Double_wosize); i++)
      printf("; %g", Double_field(array, i));
  }
  printf("|]");
}

/* Vérifie si un champ est une liste */
int is_list(value entry){
  CAMLparam1(entry);
  int size, tag;
  if (Is_long(entry)) return (Long_val(entry) == 0);
  size = Wosize_val(entry);
  tag = Tag_val(entry);
  tag == 0 && size == 2 && is_list(Field(entry, 1));
}

/* Calcul la taille d'une liste */
int list_size_aux(value entry, int s){
  CAMLparam1(entry);
  if(entry == Val_emptylist) return s; 
  return list_size_aux(Field(entry, 1), s+1);
}
int list_size(value entry){
  return list_size_aux(entry, 0);
}

/* Calcul de taille polymorphique */
value polymorphic_length(value entry){
  CAMLparam1(entry);
  int size;
  if (Is_long(entry)) return Val_int(1);
  size = Wosize_val(entry);
  switch (Tag_val(entry)){

  case Double_tag :       return Val_int(1);
  case Double_array_tag : return Val_int(size/Double_wosize);
  case String_tag :       return Val_int(string_length(entry));

  default :
    if (Tag_val(entry) >= No_scan_tag) return Val_int(0);
    if (is_list(entry)) return Val_int(list_size(entry));
    return Val_int(size);
  }
}

/* Affichage polymorphique */
value polymorphic_print(value entry){
  CAMLparam1(entry);
  if (Is_long(entry))print_int(entry);
  else {
    if (Tag_val(entry) == String_tag) print_string(entry);
    else if (Tag_val(entry) == Double_tag) print_double(entry);
    else if (Tag_val(entry) == Double_array_tag) print_array(entry);
    else if (Tag_val(entry) == Closure_tag) print_cstm(0);
    else if (Tag_val(entry) == Abstract_tag) print_cstm(1);
    else if (Tag_val(entry) == Custom_tag) print_cstm(2);
    else{
      if(Tag_val(entry) >= No_scan_tag) print_unknown();
      else{
	if(is_list(entry)) print_list(entry);
	else print_nuplet(entry);
      }
    }
  }
  fflush(stdout);
  return Val_unit;
}
