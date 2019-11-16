defmodule Scraper do
  def products() do
    [
      "ActionIQ",
      "Adobe Experience Platform",
      "Amperity",
      "Arm Treasure Data",
      "Blueshift Customer Data Activation Platform",
      "Bluevenn Unify"
    ]
  end

  def features() do
    [
      {"Software offers features and suggestions to standardize data across sources", 
        ["Normalize", "standardize", "data cleansing"]},
      {"Software integrates third-party data sources with first-party or owned data sources",
        ["third party", "3rd Party", "integrations"]},
      {"Software provides access to unstructured or raw data from each database when needed",
        ["raw data", "unstructured data"]},
      {"Software has features that enable secure data transfer, user privacy and compliance",
        ["secure", "data", "transfer", "compliance", "privacy", "protection"]}
    ]
  end
end
