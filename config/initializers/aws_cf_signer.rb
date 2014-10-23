# key_file = Rails.root.join("config", "keys", "pk-APKAJM6LY5CXG7DG62YQ.pem")
key_file = "#{Rails.root}/config/keys/pk-APKAJM6LY5CXG7DG62YQ.pem"
SIGNER = AwsCfSigner.new(key_file)