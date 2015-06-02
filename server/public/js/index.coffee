shapes = [
    "M 100,50 A 50,50 0 0 1 50,100 50,50 0 0 1 0,50 50,50 0 0 1 50,0 50,50 0 0 1 100,50 Z"
    "M 48.841797 0.24804688 L 36.271484 30.621094 L 2.6210938 35.894531 L 27.623047 57.236328 L 22.240234 90.867188 L 50.263672 73.683594 L 80.585938 89.197266 L 72.902344 57.236328 L 97.025391 33.191406 L 64.255859 30.621094 L 48.841797 0.24804688 z "
    "M 2.9042969 1.9472656 L 2.9042969 97.964844 L 97.035156 97.964844 L 97.035156 1.9472656 L 2.9042969 1.9472656 z "
    "M 48.912109 0.43554688 L 5.3105469 75.958984 L 92.515625 75.958984 L 48.912109 0.43554688 z "
    "M 30.082506,13.045993 C 15.494956,13.044173 3.668349,24.869029 3.6680129,39.456579 3.666192,54.045655 19.958023,66.085465 30.082506,77.876595 c 5.964666,6.946543 20.020927,18.805523 20.020927,18.805523 0,0 14.038793,-11.861353 19.99748,-18.805523 C 80.22106,66.082716 96.513319,54.044129 96.511499,39.456579 96.511162,24.870554 84.686938,13.046329 70.100913,13.045993 62.403136,13.050195 55.090287,16.412678 50.076076,22.253352 45.068985,16.42095 37.76936,13.059353 30.082506,13.045993 Z"]


generateButtons = ()=>
    btns = $("#buttons")
    id = 0
    w = 32
    for p in shapes
        bid = "svgbtn#{id}"
        btns.append("<button id=\"#{bid}\" class=\"btn btn-default\" style=\"padding:0; width:#{w}px; height:#{w}px;\"></button>")
        paper = Raphael bid, w, w
        shape = paper.path(p).attr("fill","#000").scale(0.3,0.3,0,0)
        id++

$ ->
    
    generateButtons()

    paper = null
    W = H = W2 = H2 = 0

    resize = ()=>
        W = $("#raphael").width()
        H = W/2
        W2= W>>1
        H2= H>>1
        paper.setSize W, H if paper
        # paper.setSize("100%", "100%") if paper
    $(window).resize resize
    resize()

    paper = Raphael("raphael", W, H)
    rect = paper.rect(W2, H2, 50, 50).attr('fill', '#FFFFFF').attr('fill-opacity',0.5)
    # Add freeTransform
    ft = paper.freeTransform(rect)
    # Hide freeTransform handles
    ft.hideHandles()
    # Show hidden freeTransform handles
    ft.showHandles()
    # Apply transformations programmatically
    ft.attrs.rotate = 45
    ft.apply()
    # Remove freeTransform completely
    ft.unplug()
    # Add freeTransform with options and callback
    ft = paper.freeTransform(rect, { keepRatio: true }, (ft, events) ->
      console.log ft.attrs
      return
    )
    # Change options on the fly
    ft.setOpts keepRatio: false