class MatchingController < ApplicationController
  def index
    @match_users = current_user.matchers
  end
end
