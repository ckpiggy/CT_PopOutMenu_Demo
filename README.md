<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>
# CT_PopOutMenu_Demo
This control is like an UIAlertView with button icon and four basic layout. I also added an UIActivityIndicatorView in this control, you can just "startAnimation" to get it work on the pop out menu.
![alt tag](https://github.com/ckpiggy/CT_PopOutMenu_Demo/blob/master/images/menu_demo.png)

#How to use
Drag the CTPopOutMenu.h, CTPopOutMenu.m file into your project and import the .h file.
Once you drag these file into your project and import .h file you have finished 50% progresses in useing the control.
To get the menu pop out on the screen, you need three more steps like these code.
<pre>
NSArray * items = ....
popMenu = [[CTPopoutMenu alloc]initWithTitle:@"Title" message:@"message" items:items];
popMenu.menuStyle = MenuStyleDefault , MenuStyleGrid , MenuStyleList or MenuStyleOval;//choose one from these
[popMenu showMenuInParentViewController:parentVC withCenter:center];
</pre>
In the last, you can setup the delegate if you need. It can tell you which item has been selected.
<pre>
popMenu.delegate = where_you_contol_the_menu;//"self" in most situation 
-(void)menu:(CTPopoutMenu*)menu willDismissWithSelectedItemAtIndex:(NSUInteger)index;
-(void)menuwillDismiss:(CTPopoutMenu *)menu ;
</pre>

#Credit
This control was inspired by <a href="https://github.com/rnystrom/RNGridMenu">RNGridMenu</a>. I learned how to blur background by taking screenshot and blur the image.

#License
see <a href="https://github.com/ckpiggy/CT_PopOutMenu_Demo/blob/master/LICENSE">LICENSE</a>

#Contact me
I started to learn obj-C on Sept.2014. If you have any suggestion about improving my coding skill, please contact me. 
e-mail:mrgmp2004@hotmail.com
