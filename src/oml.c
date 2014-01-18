#include<stdio.h>
#include<string.h>
#include<caml/mlvalues.h>
#include<caml/memory.h>

/* Prototypes */
int is_list(value entity);
void print_list(value entity);
void print_nuplet(value nuplet);
value polymorphic_print(value entity);

/* Vérifie si un champ est une liste */
int is_list(value entity){
  CAMLparam1(entity);
  int size, tag;
  if (Is_long(entity)) return (Long_val(entity) == 0);
  else{
    size = Wosize_val(entity);
    tag = Tag_val(entity);
    tag == 0 && size == 2 && is_list(Field(entity, 1));
  }
}

/* Affiche un nuplet  */
void print_nuplet(value nuplet){
  CAMLparam1(nuplet);
  int i;
  int size = Wosize_val(nuplet);
  for(i = 1; i < size; i++){
    printf(", ");
    polymorphic_print(Field(nuplet, i));
  }
}

/* Affiche une liste */
void print_list(value list){
  CAMLparam1(list);
  if(list == Val_emptylist)return;
  else{
    printf("; ");
    polymorphic_print(Field(list, 0));
    return print_list(Field(list, 1));
  }
}

/* Print polymorphique */
value polymorphic_print (value entity){
  CAMLparam1(entity); 
  int size;
  int i;
  /* Evaluation du type */
  if (Is_long(entity)){
    /* Traitement dans le cas d'un entier */
    printf("%d", Long_val(entity));
  }else{
    size = Wosize_val(entity);
    switch (Tag_val(entity)){
      
    /* Cas des chaines de caractères */
    case String_tag :
      printf("%s", String_val(entity));
      break;

    /* Cas des floats */
    case Double_tag :
      printf("%g", Double_val(entity));
      break;

    /* Cas des tableaux de flottants */
    case Double_array_tag :
      printf("[|");
      if (size > 0){
	printf ("%g", Double_field(entity, 0));
	for(i = 1; i < (size/Double_wosize); i++){
	  printf("; %g", Double_field(entity, i));
	}
      }
      printf("|]"); 
      break;

    /* Cas des types abstraits */
    case Abstract_tag :
      printf("<abstr>");
      break;

    /* Fonctions */
    case Closure_tag :
      printf("<Fun>");
      break;

    /* Identifiant custom */
    case Custom_tag :
      printf("<Custom>");
      break;

    /* Composé */
    default: 
      if(Tag_val(entity) >= No_scan_tag){
	/* tag inconnu */
	printf("?");
      }else{
	if (is_list(entity)){
	  /* Traitement des listes */
	  printf("[");
	  if (size > 0){
	    polymorphic_print(Field(entity, 0));
	    print_list(Field(entity, 1)); 
	  }
	  printf("]");
	}else{
	  /* N uplet */
	  printf("(");
	  if (size > 0){
	    polymorphic_print(Field(entity, 0));
	    print_nuplet(entity);
	  }
	  printf(")");
	}
      }
    }
  }
  /* Vidage du buffer de stdout et renvoi d'unit */
  fflush(stdout);
  return Val_unit;
}
