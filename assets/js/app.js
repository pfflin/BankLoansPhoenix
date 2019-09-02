// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$( document ).ready(function() {
    $('#loan_isHigher').css('display','none')
    Array.max = function( array ){
        return Math.max.apply( Math, array );
    };
    $('[action~="/loans"]').on('submit', function(event){
        let error = false;
        let errorMsg = "";
        if(isNaN($("#loan_amount").val()) || $("#loan_amount").val() < 1){
            error = true;
            errorMsg = 'Enter amount';
        }
        else if(!$("#loan_names").val().match(/^[A-Z][a-z]+ ([A-Z][a-z]+\s*)*$/)){
            error = true;
            errorMsg = 'Enter at least 2 names';
        }
        else if (!$("#loan_phoneNumber").val().match(/^[0-9-: ]+$/))  {
            error = true;
            errorMsg = 'Phone number consists only of digits and - : ';
        } 
        else if(!$("#loan_email").val().match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
            error = true;
            errorMsg = 'Incorrect email';
        }
        if (error){
            $('.alert-danger').text(errorMsg)
            event.preventDefault();
        }else{
            let lastOffer = $("#loan_amount").val();  
            let max = Array.max(checkLocalStorageForOffers());
            if(lastOffer > max){
                $("#loan_isHigher").prop("checked", true);
            };
            setOfferLocalStorage(lastOffer);
        }
    });
    function checkLocalStorageForOffers(){
        if(sessionStorage.getItem('previousOffers') !== null){
            return JSON.parse(sessionStorage.getItem('previousOffers'));
        }
        else{
            return [];
        }
    }
    function setOfferLocalStorage(lastOffer){
        let offers = checkLocalStorageForOffers();
        offers.push(lastOffer)
        sessionStorage.setItem('previousOffers',JSON.stringify(offers))
    }
});