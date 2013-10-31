library polymer_ui_icon;

import 'package:polymer/polymer.dart';
import 'package:logging/logging.dart';
import 'package:polymer_ui_elements/polymer_ui_theme_aware/polymer_ui_theme_aware.dart';

@CustomTag('polymer-ui-icon')
class PolymerUiIcon extends PolymerUiThemeAware {
  PolymerUiIcon.created() : super.created() {
    _logger.finest('created');
  }

  final _logger = new Logger('PolymerUiIcon');
  
  /**
   * The URL of an image for the icon.
   */
  @published String src = '';
  
  /**
   * Specifies the size of the icon.
   */
  @published int size = 24;
  
  /**
   * Specifies the icon from the Polymer icon set.
   */
  @published String icon = '';
  
  int bx = 0;
  int by = 0;

  // memoize offset because getComputedStyle is expensive
  var themes = {};

  var icons = new Map<String, int>();
  
  @published int index;
      
  @override 
  void polymerCreated() {
    _logger.finest('polymerCreated');
    
    var _icons = [
                 'drawer',
                 'menu',
                 'search',
                 'dropdown',
                 'close',
                 'add',
                 'trash',
                 'refresh',
                 'settings',
                 'dialoga',
                 'left',
                 'right',
                 'down',
                 'up',
                 'grid',
                 'contact',
                 'account',
                 'plus',
                 'time',
                 'marker',
                 'briefcase',
                 'array',
                 'columns',
                 'list',
                 'modules',
                 'quilt',
                 'stream',
                 'maximize',
                 'shrink',
                 'sort',
                 'shortcut',
                 'dialog',
                 'twitter',
                 'facebook',
                 'favorite',
                 'gplus',
                 'filter',
                 'tag',
                 'plusone',
                 'dots'
                 ];
    int i = 0;
    _icons.forEach((name) {
      icons[name] = i++;
    });
    
    super.polymerCreated();
  }
  
  @override
  void ready() {
    super.ready();
    this.sizeChanged();
  }
    
  void sizeChanged() {
    _logger.finest('sizeChanged');
    
    this.style.width =  '${this.size}px';
    this.style.height = '${this.size}px';
  }
  
  void iconChanged(old) {
    _logger.finest('iconChanged');
    
    if(icons.containsKey(this.icon)) {
      this.index = icons[this.icon];
    } else {
      this.index = -1;
    }
  }
  
  void indexChanged(old) {
    _logger.finest('indexChanged');
    
    this.classes.add('polymer-ui-icons');
    this.by = -this.size * this.index;
    this.updateIcon();
  }
  
  void srcChanged() {
    _logger.finest('srcChanged');
    
    this.classes.remove('polymer-ui-icons');
    this.style.backgroundImage = 'url(' + this.src + ')';
    this.updateIcon();
  }
  
  void activeThemeChanged(old) {
    _logger.finest('activeThemeChanged');
    
    super.activeThemeChanged(old);
    this.style.backgroundPosition = '';
    this.bx = calcThemeOffset(this.activeTheme, this);
    this.updateIcon();
  }
  
  
  void updateIcon() {
    _logger.finest('updateIcon');
    
    if (this.src != null && this.src.isNotEmpty) {
      this.style.backgroundPosition = 'center';
    } else {
      this.style.backgroundPosition = '${this.bx}px ${this.by}px';
    }
  }

  int calcThemeOffset(theme, node) {
    _logger.finest('calcThemeOffset');
    
    if (themes[theme] == null) {
      var bg = getComputedStyle(node).backgroundPosition.split(' ');
      bg.removeAt(0);
      var offset = double.parse(bg[0]); // parseFloat(
      _logger.finest('calcThemeOffset - theme: ${theme}; offset: ${offset}');
      themes[theme] = offset;
    }
    return themes[theme]; 
  }  
}
