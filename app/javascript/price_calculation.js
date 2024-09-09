document.addEventListener('turbo:load', initializePriceCalculation)
document.addEventListener('turbo:render', initializePriceCalculation)

function initializePriceCalculation() {
  const priceInput = document.getElementById('item-price')
  const feeDisplay = document.getElementById('add-tax-price')
  const profitDisplay = document.getElementById('profit')

  if (!priceInput) return

  function calculate() {
    const price = parseInt(priceInput.value) || 0
    const fee = Math.floor(price * 0.1)
    const profit = price - fee

    feeDisplay.textContent = fee
    profitDisplay.textContent = profit
  }

  priceInput.removeEventListener('input', calculate)
  priceInput.addEventListener('input', calculate)

  calculate() // 初期計算
}