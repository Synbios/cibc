var RevolutionSlider = function () {

    return {
        
        //Revolution Slider - Full Width
        initRSfullWidth: function () {
            var revapi;
            jQuery(document).ready(function() {
                revapi = jQuery('.tp-banner').revolution(
                {
                    delay:9000,
                    startwidth:1170,
                    startheight:400,
                    hideThumbs:10,
                    navigationStyle:"preview4"
                });
            });
        },

        // Custmized full width
        initRSfullWidthC: function () {
            var revapi;
            jQuery(document).ready(function() {
                revapi = jQuery('.tp-banner').revolution(
                {
                    delay:9000,
                    startwidth:1170,
                    //startheight:400,
                    startheight:780,
                    hideThumbs:10,
                    navigationStyle:"preview4"
                });
            });
        }, 

        // Custmized full width
        initRSfullWidthD: function () {
            var revapi;
            jQuery(document).ready(function() {
                revapi = jQuery('.tp-banner').revolution(
                {
                    lazyType: "single",
                    delay:9000,
                    startwidth:1170,
                    startheight:580,
                    hideThumbs:10,
                    navigationStyle:"preview4"
                });
            });
        },        

        //Revolution Slider - Full Screen Offset Container
        initRSfullScreenOffset: function () {
            var revapi;
            jQuery(document).ready(function() {
               revapi = jQuery('.tp-banner').revolution(
                {
                    delay:15000,
                    startwidth:1170,
                    startheight:400,
                    hideThumbs:10,
                    fullWidth:"off",
                    fullScreen:"on",
                    hideCaptionAtLimit: "",
                    dottedOverlay:"twoxtwo",
                    navigationStyle:"preview4",
                    fullScreenOffsetContainer: ".header"
                });
            });
        }        

    };
}();        