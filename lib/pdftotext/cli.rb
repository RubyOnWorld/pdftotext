module Pdftotext
  class CLI

    DEFAULT_OPTIONS = {
      :layout => true
    }

    def run_command(*args)
      options = DEFAULT_OPTIONS.merge(args.pop)
      args = args.concat options_to_args(options)
      puts args.inspect
      output, status = Open3.capture2e(bin_path, *args)
      raise "Command `#{bin_path} #{args.join(" ")}` failed: #{output}" if status.exitstatus != 0
      output
    end

    private

    def bin_path
      @bin_path ||= Cliver.detect!('pdftotext')
    end

    def options_to_args(options)
      args = []
      options.each do |key, value|
        next if value === false
        if value === true
          args.push "-#{key}"
        else
          args.push "-#{key} #{value}"
        end
      end
      args
    end
  end
end
