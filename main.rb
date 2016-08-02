# encoding: utf-8
require 'clipboard'
class Emoter
	attr_reader :txt, :emote 
	FIRSTLINE = "　　　　　　　　　　　　　　　　　　　　　　　" #only for kaetsuu rn
	NEWLINE_UNE = " 　　　　　　　　　　　　　　　　　　　　　　　" #newline with 0 emote. 3 diff than ^^

	#2 SPEC SPACES PER EMOTE
	SUPPORTED = ('A'..'Z').to_a + ('a'..'z').to_a + ".?!<>[]{}".chars #add supported characters here
	def txt=(e)
		raise "Character(s) not supported yet!" unless e.is_a?(String) && e.chars.all? {|chr| SUPPORTED.include?(chr)} #probs more efficient way but trivial rn
		@txt = e
	end 
	def emote=(e)
		raise "Invalid emote!" unless e.is_a?(String)
		@emote = e
	end
	def initialize(temp_txt, temp_emote="Kappa")
		self.txt=temp_txt
		self.emote=temp_emote
	end
	def copy
		Clipboard.copy(set)
	end
	
	private
	
	def set
		final = [FIRSTLINE]
		f = File.open("./patterns.txt", "r")
		a = f.readlines
		f.close
		read = false
		@txt.chars.each do |o|
			a.each do |p|
				p.chomp!
				if p == o
					read = true
				elsif read
					if p == "-"
						read = false
						final << NEWLINE_UNE
						break
					else
						count = final.count("*")
						p.gsub!(/^/, ".　").gsub!(/[ ]/, "　　") #
						final << p.gsub(/[*]/, @emote+ " ") + NEWLINE_UNE[0..NEWLINE_UNE.length-(count*2)]
					end
				end
			end
		end
		final.join
	end
end
Emoter.new(ARGV[0], ARGV[1]).copy

__END__
TODO: implement a fix for 4 emotes on a line; looks ugly