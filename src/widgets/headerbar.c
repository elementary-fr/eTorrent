/* headerbar.c generated by valac 0.25.3, the Vala compiler
 * generated from headerbar.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>


#define TRANSFERT_WIDGETS_TYPE_HEADER_BAR (transfert_widgets_header_bar_get_type ())
#define TRANSFERT_WIDGETS_HEADER_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBar))
#define TRANSFERT_WIDGETS_HEADER_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBarClass))
#define TRANSFERT_WIDGETS_IS_HEADER_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TRANSFERT_WIDGETS_TYPE_HEADER_BAR))
#define TRANSFERT_WIDGETS_IS_HEADER_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TRANSFERT_WIDGETS_TYPE_HEADER_BAR))
#define TRANSFERT_WIDGETS_HEADER_BAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBarClass))

typedef struct _TransfertWidgetsHeaderBar TransfertWidgetsHeaderBar;
typedef struct _TransfertWidgetsHeaderBarClass TransfertWidgetsHeaderBarClass;
typedef struct _TransfertWidgetsHeaderBarPrivate TransfertWidgetsHeaderBarPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

#define TRANSFERT_WIDGETS_TYPE_CLOSE_MENU (transfert_widgets_close_menu_get_type ())
#define TRANSFERT_WIDGETS_CLOSE_MENU(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TRANSFERT_WIDGETS_TYPE_CLOSE_MENU, TransfertWidgetsCloseMenu))
#define TRANSFERT_WIDGETS_CLOSE_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TRANSFERT_WIDGETS_TYPE_CLOSE_MENU, TransfertWidgetsCloseMenuClass))
#define TRANSFERT_WIDGETS_IS_CLOSE_MENU(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TRANSFERT_WIDGETS_TYPE_CLOSE_MENU))
#define TRANSFERT_WIDGETS_IS_CLOSE_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TRANSFERT_WIDGETS_TYPE_CLOSE_MENU))
#define TRANSFERT_WIDGETS_CLOSE_MENU_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TRANSFERT_WIDGETS_TYPE_CLOSE_MENU, TransfertWidgetsCloseMenuClass))

typedef struct _TransfertWidgetsCloseMenu TransfertWidgetsCloseMenu;
typedef struct _TransfertWidgetsCloseMenuClass TransfertWidgetsCloseMenuClass;

struct _TransfertWidgetsHeaderBar {
	GtkHeaderBar parent_instance;
	TransfertWidgetsHeaderBarPrivate * priv;
};

struct _TransfertWidgetsHeaderBarClass {
	GtkHeaderBarClass parent_class;
};

struct _TransfertWidgetsHeaderBarPrivate {
	GtkMenuButton* _close_button;
};


static gpointer transfert_widgets_header_bar_parent_class = NULL;

GType transfert_widgets_header_bar_get_type (void) G_GNUC_CONST;
#define TRANSFERT_WIDGETS_HEADER_BAR_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBarPrivate))
enum  {
	TRANSFERT_WIDGETS_HEADER_BAR_DUMMY_PROPERTY,
	TRANSFERT_WIDGETS_HEADER_BAR_CLOSE_BUTTON
};
TransfertWidgetsHeaderBar* transfert_widgets_header_bar_new (void);
TransfertWidgetsHeaderBar* transfert_widgets_header_bar_construct (GType object_type);
GtkMenuButton* transfert_widgets_header_bar_get_close_button (TransfertWidgetsHeaderBar* self);
static void transfert_widgets_header_bar_set_close_button (TransfertWidgetsHeaderBar* self, GtkMenuButton* value);
static GObject * transfert_widgets_header_bar_constructor (GType type, guint n_construct_properties, GObjectConstructParam * construct_properties);
TransfertWidgetsCloseMenu* transfert_widgets_close_menu_new (void);
TransfertWidgetsCloseMenu* transfert_widgets_close_menu_construct (GType object_type);
GType transfert_widgets_close_menu_get_type (void) G_GNUC_CONST;
static void transfert_widgets_header_bar_finalize (GObject* obj);
static void _vala_transfert_widgets_header_bar_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void _vala_transfert_widgets_header_bar_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);


TransfertWidgetsHeaderBar* transfert_widgets_header_bar_construct (GType object_type) {
	TransfertWidgetsHeaderBar * self = NULL;
	self = (TransfertWidgetsHeaderBar*) g_object_new (object_type, NULL);
	return self;
}


TransfertWidgetsHeaderBar* transfert_widgets_header_bar_new (void) {
	return transfert_widgets_header_bar_construct (TRANSFERT_WIDGETS_TYPE_HEADER_BAR);
}


GtkMenuButton* transfert_widgets_header_bar_get_close_button (TransfertWidgetsHeaderBar* self) {
	GtkMenuButton* result;
	GtkMenuButton* _tmp0_ = NULL;
	g_return_val_if_fail (self != NULL, NULL);
	_tmp0_ = self->priv->_close_button;
	result = _tmp0_;
	return result;
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static void transfert_widgets_header_bar_set_close_button (TransfertWidgetsHeaderBar* self, GtkMenuButton* value) {
	GtkMenuButton* _tmp0_ = NULL;
	GtkMenuButton* _tmp1_ = NULL;
	g_return_if_fail (self != NULL);
	_tmp0_ = value;
	_tmp1_ = _g_object_ref0 (_tmp0_);
	_g_object_unref0 (self->priv->_close_button);
	self->priv->_close_button = _tmp1_;
	g_object_notify ((GObject *) self, "close-button");
}


static GObject * transfert_widgets_header_bar_constructor (GType type, guint n_construct_properties, GObjectConstructParam * construct_properties) {
	GObject * obj;
	GObjectClass * parent_class;
	TransfertWidgetsHeaderBar * self;
	GtkMenuButton* _tmp0_ = NULL;
	GtkMenuButton* _tmp1_ = NULL;
	GtkMenuButton* _tmp2_ = NULL;
	TransfertWidgetsCloseMenu* _tmp3_ = NULL;
	TransfertWidgetsCloseMenu* _tmp4_ = NULL;
	GtkMenuButton* _tmp5_ = NULL;
	GtkImage* _tmp6_ = NULL;
	GtkImage* _tmp7_ = NULL;
	GtkMenuButton* _tmp8_ = NULL;
	GtkSeparator* _tmp9_ = NULL;
	GtkSeparator* _tmp10_ = NULL;
	parent_class = G_OBJECT_CLASS (transfert_widgets_header_bar_parent_class);
	obj = parent_class->constructor (type, n_construct_properties, construct_properties);
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBar);
	gtk_header_bar_set_title ((GtkHeaderBar*) self, "Transfert");
	_tmp0_ = (GtkMenuButton*) gtk_menu_button_new ();
	g_object_ref_sink (_tmp0_);
	_tmp1_ = _tmp0_;
	transfert_widgets_header_bar_set_close_button (self, _tmp1_);
	_g_object_unref0 (_tmp1_);
	_tmp2_ = self->priv->_close_button;
	_tmp3_ = transfert_widgets_close_menu_new ();
	g_object_ref_sink (_tmp3_);
	_tmp4_ = _tmp3_;
	gtk_menu_button_set_popup (_tmp2_, (GtkMenu*) _tmp4_);
	_g_object_unref0 (_tmp4_);
	_tmp5_ = self->priv->_close_button;
	_tmp6_ = (GtkImage*) gtk_image_new_from_icon_name ("dialog-close", GTK_ICON_SIZE_BUTTON);
	g_object_ref_sink (_tmp6_);
	_tmp7_ = _tmp6_;
	gtk_button_set_image ((GtkButton*) _tmp5_, (GtkWidget*) _tmp7_);
	_g_object_unref0 (_tmp7_);
	_tmp8_ = self->priv->_close_button;
	gtk_header_bar_pack_start ((GtkHeaderBar*) self, (GtkWidget*) _tmp8_);
	_tmp9_ = (GtkSeparator*) gtk_separator_new (GTK_ORIENTATION_VERTICAL);
	g_object_ref_sink (_tmp9_);
	_tmp10_ = _tmp9_;
	gtk_header_bar_pack_start ((GtkHeaderBar*) self, (GtkWidget*) _tmp10_);
	_g_object_unref0 (_tmp10_);
	return obj;
}


static void transfert_widgets_header_bar_class_init (TransfertWidgetsHeaderBarClass * klass) {
	transfert_widgets_header_bar_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (TransfertWidgetsHeaderBarPrivate));
	G_OBJECT_CLASS (klass)->get_property = _vala_transfert_widgets_header_bar_get_property;
	G_OBJECT_CLASS (klass)->set_property = _vala_transfert_widgets_header_bar_set_property;
	G_OBJECT_CLASS (klass)->constructor = transfert_widgets_header_bar_constructor;
	G_OBJECT_CLASS (klass)->finalize = transfert_widgets_header_bar_finalize;
	g_object_class_install_property (G_OBJECT_CLASS (klass), TRANSFERT_WIDGETS_HEADER_BAR_CLOSE_BUTTON, g_param_spec_object ("close-button", "close-button", "close-button", gtk_menu_button_get_type (), G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
}


static void transfert_widgets_header_bar_instance_init (TransfertWidgetsHeaderBar * self) {
	self->priv = TRANSFERT_WIDGETS_HEADER_BAR_GET_PRIVATE (self);
}


static void transfert_widgets_header_bar_finalize (GObject* obj) {
	TransfertWidgetsHeaderBar * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBar);
	_g_object_unref0 (self->priv->_close_button);
	G_OBJECT_CLASS (transfert_widgets_header_bar_parent_class)->finalize (obj);
}


GType transfert_widgets_header_bar_get_type (void) {
	static volatile gsize transfert_widgets_header_bar_type_id__volatile = 0;
	if (g_once_init_enter (&transfert_widgets_header_bar_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (TransfertWidgetsHeaderBarClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) transfert_widgets_header_bar_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (TransfertWidgetsHeaderBar), 0, (GInstanceInitFunc) transfert_widgets_header_bar_instance_init, NULL };
		GType transfert_widgets_header_bar_type_id;
		transfert_widgets_header_bar_type_id = g_type_register_static (gtk_header_bar_get_type (), "TransfertWidgetsHeaderBar", &g_define_type_info, 0);
		g_once_init_leave (&transfert_widgets_header_bar_type_id__volatile, transfert_widgets_header_bar_type_id);
	}
	return transfert_widgets_header_bar_type_id__volatile;
}


static void _vala_transfert_widgets_header_bar_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	TransfertWidgetsHeaderBar * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBar);
	switch (property_id) {
		case TRANSFERT_WIDGETS_HEADER_BAR_CLOSE_BUTTON:
		g_value_set_object (value, transfert_widgets_header_bar_get_close_button (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_transfert_widgets_header_bar_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	TransfertWidgetsHeaderBar * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, TRANSFERT_WIDGETS_TYPE_HEADER_BAR, TransfertWidgetsHeaderBar);
	switch (property_id) {
		case TRANSFERT_WIDGETS_HEADER_BAR_CLOSE_BUTTON:
		transfert_widgets_header_bar_set_close_button (self, g_value_get_object (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


