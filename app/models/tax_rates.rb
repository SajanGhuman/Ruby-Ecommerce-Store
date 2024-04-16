class TaxRates
    def self.load_rates
      YAML.load_file("#{Rails.root}/config/tax_rates.yml")['tax_rates']
    end
  end
  
  