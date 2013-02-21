
task :default => [:welcome]

desc "Welcome to Foreman Bare Metal"
task :welcome do
  puts <<EOF
Welcome to the Foreman Bare Metal project
=========================================
try running rake -T to see the available tasks
EOF
end

desc "Generate the ipxe template file"
task :ipxe => ['foreman-metal.ipxe'] do
end

desc "Generate foreman-metal.ipxe"
file 'foreman-metal.ipxe' => ['foreman-metal.ipxe.erb'] do
  require 'erb'
  require 'yaml'

  @settings = YAML.load_file('conf/settings.yaml')

  ipxe = ERB.new(File.read("foreman-metal.ipxe.erb"), nil, '%<>')
  File.open('foreman-metal.ipxe', File::RDWR|File::CREAT, 0644) do |f|
    bytes = f.write ipxe.result(binding)
    if !bytes.nil? and bytes > 0
      puts "Wrote #{bytes} byte(s) to foreman-metal.ipxe"
    end
  end

end

desc "Generate iso image (please invoke with 'sudo rake iso')"
task :iso do
  system('/usr/bin/livecd-creator --tmpdir=/tmp --cache /var/cache/live --verbose \
      --config foreman-metal.ks --title="Foreman Metal" --product "Metal" \
      -f foreman-metal --compression-type=gzip')
  puts "Status: #{$?}"

end

desc "Generate pxe images (please invoke with 'sudo rake pxe')"
task :pxe do
  system('/usr/bin/livecd-iso-to-pxeboot foreman-metal.iso')
  puts "Status: #{$?}"
end

desc "Generate images (iso + pxe)"
task :images do
  Rake::Task[:iso].invoke
  Rake::Task[:pxe].invoke
end

