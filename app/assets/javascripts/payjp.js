// $(document).on('turbolinks:load', function() {
//   var form = $("#inputForm");
//   Payjp.setPublicKey('pk_test_46e0715c69e5c4ec9239df4c');
//   $(document).on("click", "#content-bottom--add-btn", function(e) {

//     e.preventDefault();
//     form.find("input[type=submit]").prop("disabled", true);

//     var card = {
//         number: $("#payment_card_no").val(),
//         cvc: $("#payment_card_cvc").val(),
//         exp_month: $("#payment_expiration_date_1i").val(),
//         exp_year: $("#payment_expiration_date_2i").val(),
//     };
//     Payjp.createToken(card, function(s, response) {
//       if (response.error) {
//         alert('トークン作成エラー発生');
//       }
//       else {
//         $(".number").removeAttr("name");
//         $(".cvc").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");
//         var token = response.id;

//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         form.get(0).submit();
//       }
//     });
//   });
// });

document.addEventListener(
  "DOMContentLoaded", (e) => {
    Payjp.setPublicKey("pk_test_8a02eb526da8e8fce8bd4e8c");
    const btn = document.getElementById('token_submit'); 
    btn.addEventListener("click", (e) => {　
      e.preventDefault();　

      const card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      }; 

      Payjp.createToken(card, (status, response) => {
        if (status === 200) { 
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); 
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); 
          document.inputForm.submit();
          alert("登録が完了しました");
        } else {
          alert("カード情報が正しくありません。"); 
        }
      });
    });
  },false);