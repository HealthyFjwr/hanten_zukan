// Stimulus Controller: URLをクリップボードにコピーする機能
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // data-clipboard-target="button" に対応するDOM要素を取得する宣言
  static targets = ["button"]

  copy() {
    // navigator.clipboard.writeText() : ブラウザのクリップボードAPIでURLを書き込む
    // window.location.href : 現在表示しているページのURL
    navigator.clipboard.writeText(window.location.href).then(() => {
      // コピー成功時 → ボタンの innerHTML を一時的に変更する
      const original = this.buttonTarget.innerHTML

      // テキストがあるボタン（topページ）はアイコン+テキスト、アイコンのみ（showページ）はチェックマークだけ
      const hasText = this.buttonTarget.textContent.trim().length > 0
      this.buttonTarget.innerHTML = hasText
        ? `<svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" /></svg> コピーしました`
        : `<svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" /></svg>`
      this.buttonTarget.disabled = true

      // 2秒後にボタンを元に戻す
      setTimeout(() => {
        this.buttonTarget.innerHTML = original
        this.buttonTarget.disabled = false
      }, 2000)
    })
  }
}
