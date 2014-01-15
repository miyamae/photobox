#!/usr/bin/env ruby

require 'bundler'
Bundler.require

if ARGV.size < 2
  STDERR.puts 'Usage: photobox.rb OUTPUT_DIR JPG_FILES...'
  exit
end

output_base_dir = File.expand_path(ARGV[0])
jpg_files = ARGV[1..-1]

unless FileTest.exist?(output_base_dir) && FileTest.directory?(output_base_dir)
  STDERR.puts "#{output_base_dir}: directory not found."
  exit
end

jpg_files.each do |file|
  begin
    exif = EXIFR::JPEG.new(file) rescue nil
    if exif && exif.date_time_original
      otime = exif.date_time_original
    else
      otime = File.mtime(file)
    end
    output_dir = [output_base_dir, otime.strftime('%Y%m%d')].join('/')
    unless FileTest.exist?(output_dir)
      Dir.mkdir output_dir
    end
    puts "> #{[output_dir, File.basename(file)].join('/')}"
    FileUtils.mv file, output_dir
  rescue
    STDERR.puts "#{File.expand_path(file)}: #{$!}"
  end
end
