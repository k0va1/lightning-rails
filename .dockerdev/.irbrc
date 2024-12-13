if ENV["HISTFILE"]
  hist_dir = ENV["HISTFILE"].sub(/\/[^\/]+$/, "")
  IRB.conf[:HISTORY_FILE] = File.join(hist_dir, ".irb_history")
end
