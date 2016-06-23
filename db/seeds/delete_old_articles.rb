
Article.where(publish: 'No').each do |f|
  t = Date.today
  delete_day = (t - 120)

  if f.date_published.to_date < delete_day
    f.delete
  end

end
