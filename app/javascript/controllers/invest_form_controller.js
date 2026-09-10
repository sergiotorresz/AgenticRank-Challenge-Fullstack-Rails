import { Controller } from "@hotwired/stimulus"

// Client-side UX guard for the invest form: formats the amount input and
// disables the submit button while the request is in flight, so a slow
// double-click doesn't feel broken. This is a UX nicety only -- the
// authoritative duplicate-submission guard lives in the database.
export default class extends Controller {
  static targets = ["amount", "submit"]

  connect() {
    this.element.addEventListener("turbo:submit-start", this.disableSubmit.bind(this))
    this.element.addEventListener("turbo:submit-end", this.enableSubmit.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("turbo:submit-start", this.disableSubmit.bind(this))
    this.element.removeEventListener("turbo:submit-end", this.enableSubmit.bind(this))
  }

  disableSubmit() {
    if (!this.hasSubmitTarget) return

    this.submitTarget.disabled = true
    this.submitTarget.value = "Investing..."
  }

  enableSubmit() {
    if (!this.hasSubmitTarget) return

    this.submitTarget.disabled = false
    this.submitTarget.value = "Invest"
  }
}
