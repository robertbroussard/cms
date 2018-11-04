//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): robert
  // Date and time: 11/03/18, 22:40:30
  // ----------------------------------------------------
  // Method: Generate_Pics
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

  //Here's a simple example inspired by the 4d-component-generate-icon.
  //Keith-CDI

$width:=3
$opacity:=80
$rw:=40

$color:="black"  // normal
$svg:=SVG_New (58;58)
$ref:=SVG_New_rect ($svg;9;9;$rw;$rw;2;2;$color;"white";$width)
SVG_SET_OPACITY ($ref;0;$opacity)
$normal:=SVG_Export_to_picture ($svg)
SVG_CLEAR ($svg)

$color:="green"  // click
$svg:=SVG_New (58;58)
$ref:=SVG_New_rect ($svg;9;9;$rw;$rw;2;2;$color;"white";$width)
SVG_SET_OPACITY ($ref;0;$opacity)
$click:=SVG_Export_to_picture ($svg)
SVG_CLEAR ($svg)

$color:="deepskyblue"  // hover
$svg:=SVG_New (58;58)
$ref:=SVG_New_rect ($svg;9;9;$rw;$rw;2;2;$color;"white";$width)
SVG_SET_OPACITY ($ref;0;$opacity)
$hover:=SVG_Export_to_picture ($svg)
SVG_CLEAR ($svg)

$color:="silver"  // disable
$svg:=SVG_New (58;58)
$ref:=SVG_New_rect ($svg;9;9;$rw;$rw;2;2;$color;"white";$width)
SVG_SET_OPACITY ($ref;0;$opacity)
$disabled:=SVG_Export_to_picture ($svg)
SVG_CLEAR ($svg)


$pict:=$normal/$click/$hover/$disabled  // this creates the "4 state" picture!

TRANSFORM PICTURE:C988($pict;Scale:K61:2;0.66;0.66)  // size to fit
CONVERT PICTURE:C1002($pict;".png")  // allows pasting into Preview

$0:=$pict

SET PICTURE TO PASTEBOARD:C521($pict)
  //SVGTool_SHOW_IN_VIEWER ($svg)

  //-----------------------------
