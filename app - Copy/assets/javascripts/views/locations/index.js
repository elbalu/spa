Spa.Views.LocationsIndex = Backbone.View.extend({
    el: $('#mapCanvas'),
    template: 'location',
    events: {
    'submit form': 'saveLocation',
  },
    initialize: function (opts) {
        this.collection.on('reset', this.render, this);
    },
    render: function () {
        dust.render('location', {
            locations: this.collection
        }, function (err, out) {
            $('#mapCanvas').html(out);
        });
        var map;
        GMaps.geolocate({
            success: function (position) {
                infoWindow = new google.maps.InfoWindow({});
                var circleCount = 0;
                map = new GMaps({
                    div: '#map',
                    lat: position.coords.latitude,
                    lng: position.coords.longitude,
                    zoom: 12,
                    click: function (e) {
                        circleCount++;
                        if (circleCount <= 1) {
                            gencir(e.latLng.lat(), e.latLng.lng());
                        } else {
                            console.log('more than 2');
                        }
                    }
                });

                function gencir(lat, lng) {
                    GMaps.geocode({
                        lat: lat,
                        lng: lng,
                        callback: function (results, status) {
                            if (status == 'OK') {
                                map.setCenter(lat, lng);
                                var marker = map.addMarker({
                                    lat: lat,
                                    lng: lng,
                                    title: 'click on the marker to set your location',
                                    draggable: true,
                                    mouseover: function (point) {
                                        var latlng = new google.maps.LatLng(lat, lng);
                                        infoWindow.setContent('<form id=\"new-location\" class=\"form-horizontal\"><p>Save your location: ' + results[0].address_components[1].long_name + '</p><p>Is this your: <select class=\"span2\"><option>working location</option><option>studying location</option><option>living location</option></select></p><p>Organization name: <input type=\"text\" class=\"span2 orgName\" name=\"orgName\" id=\"orgName\"/><input type=\"submit\" value=\"save\"/></form>');
                                        infoWindow.setPosition(latlng);
                                        infoWindow.open(map.map);
                                        var country;
                                        for (i = 0; i < results[0].address_components.length; i++) {
                                            for (j = 0; j < results[0].address_components[i].types.length; j++) {
                                                if (results[0].address_components[i].types[j] == "country") country = results[0].address_components[i].short_name;
                                            }
                                        }
                                        $(".orgName").geocomplete({
                                            radius: 50000,
                                            componentRestrictions: {
                                                country: country
                                            },
                                            types: ["establishment"]
                                        });
                                    },
                                    dragEnd: function (e) {}
                                });
                                var circle = map.drawCircle({
                                    lat: position.coords.latitude,
                                    lng: position.coords.longitude,
                                    radius: 5000,
                                    fillColor: '#2c2b27',
                                    click: function (e) {
                                        gencir(e.latLng.lat(), e.latLng.lng());
                                    },
                                });
                                circle.bindTo('center', marker, 'position');
                                infoWindow.bindTo('center', marker, 'position');
                            }
                        }
                    });
                }
                gencir(position.coords.latitude, position.coords.longitude);
            },
            error: function (error) {
                alert('Geolocation failed: ' + error.message);
            },
            not_supported: function () {
                alert("Your browser does not support geolocation");
            },
            always: function () {}
        });
        return this;
    },
     saveLocation: function (e) {
        var target = $(e.target);
        e.preventDefault();
        var attributes = {
            orgName: $('#orgName').val(),
            
        }
        this.collection.create(attributes, {
            wait: false,
            success: function () {
                $('#new-location')[0].reset();
            },
            error: this.handleError
        });
        this.collection.trigger('reset');
        //alert("created");
    },
    remove: function () {}
});