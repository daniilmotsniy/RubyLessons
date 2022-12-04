require 'aws-sdk-s3'

ACCESS_KEY_ID = "AKIAS276M2IT6SJROHHP"
SECRET_ACCESS_KEY = "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"
REGION_ID = "us-east-1"
BUCKET_NAME = "cloudmotsnyi"


def gauss_kuzmin_distribution(k)
  # this func returns Gauss-Kuzmin distribution for selected k
  -Math.log((1 - (1 / ((1 + k) * (1 + k)).to_f)), 2)
end

begin
  file = File.open('results.csv', 'w')
  # file.write("k,value\n")
  (0..20).each { |_|
    k = rand(1...1000)
    file.write("#{k},#{gauss_kuzmin_distribution k}\n")
  }
rescue IOError => e
  puts e
ensure
  file.close unless file.nil?
end


def upload_2_s3
  credentials = Aws::Credentials.new(
    ACCESS_KEY_ID,
    SECRET_ACCESS_KEY
  )
  s3 = Aws::S3::Client.new(
    region: REGION_ID,
    credentials: credentials
  )

  File.open('results.csv', 'rb') do |file|
    puts "start uploading results.csv to s3"
    resp = s3.put_object(bucket: BUCKET_NAME, acl: "public-read", key: 'results.csv', body: file)
    puts resp
  end

  puts "File should be available at https://#{BUCKET_NAME}.s3.amazonaws.com/results.csv"
end

upload_2_s3