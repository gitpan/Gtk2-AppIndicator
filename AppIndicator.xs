#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <glib.h>
#include <libappindicator/app-indicator.h>
#include <gperl.h>

MODULE = Gtk2::AppIndicator		PACKAGE = Gtk2::AppIndicator


GObject *appindicator_new(name,iconname)
		char *name
		char *iconname
    CODE:
		AppIndicator *theApp;
		theApp=app_indicator_new (name,iconname,APP_INDICATOR_CATEGORY_APPLICATION_STATUS);
		RETVAL=(GObject *) theApp;
    OUTPUT:
		RETVAL
		
void appindicator_set_icon_theme_path(self,path)
		GObject *self
		char *path
	CODE:
		app_indicator_set_icon_theme_path((AppIndicator *) self,path);
		
void appindicator_set_icon_name_active(self,name,text) 
		GObject *self
		char *name
		char *text
	CODE:
		app_indicator_set_icon_full ((AppIndicator *) self, name , text);
	
	
void appindicator_set_icon_name_attention(self,name,text)		
		GObject *self
		char *name
		char *text
	CODE:
		app_indicator_set_attention_icon_full((AppIndicator *) self, name , text);
		
		
void appindicator_set_active(self)
		GObject *self
	CODE:
		app_indicator_set_status ((AppIndicator *) self, APP_INDICATOR_STATUS_ACTIVE);

void appindicator_set_attention(self)
		GObject *self
	CODE:
		app_indicator_set_status ((AppIndicator *) self, APP_INDICATOR_STATUS_ATTENTION);

void appindicator_set_menu(self,menu)
		GObject *self
		GObject *menu
	CODE:
		app_indicator_set_menu((AppIndicator *) self,(GtkMenu *) menu);



