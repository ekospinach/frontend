require 'spec_helper'

describe "Fundraiser Pledges" do
  specify do
    @browser.goto_route "#"

    # find a fundraiser card and click on it
    bounty_card = @browser.a(text: 'Pledge!')
    bounty_card.wait_until_present

    # goto_route instead of .click because it sometimes doesn't scroll enough and chatbar gets the click
    @browser.goto_route '#'+bounty_card.href.split('#').last

    @browser.a(text: 'Make a Pledge').when_present.click

    # make a pledge to this fundraiser
    @browser.text_field(id: 'pledge-amount').when_present.set(25)
    @browser.radio(id: 'payment_method_paypal').click
    @browser.button(value: 'Continue to payment').click

    proceed_through_paypal_sandbox_flow!

    @browser.h2(text: 'Thanks for your contribution').wait_until_present
  end
end