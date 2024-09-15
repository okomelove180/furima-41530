const pay = () => {
  const payjp = Payjp('pk_test_4ebbaacf2f09a2c843395173');// PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const button = document.getElementById("charge-form");
  if (button) {
    button.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      });
      e.preventDefault();
    });
    console.log("イベントリスナーが正常に設定されました");
  } else {
    console.log("購入ボタンが見つかりませんでした");
  }
};

window.addEventListener("turbo:load", pay);