
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

