# encoding: utf-8
require 'clipboard'
class Emoter
	attr_reader :txt, :emote
	NEWLINE = " 　　　　　　　　　　　　　　　　　"
	SUPPORTED = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a << " " #add supported characters here
	def txt=(e)
		raise "Not alphanumeric!" unless e.is_a?(String) && e.chars.all? {|chr| SUPPORTED.include?(chr)} #probs more efficient way but trivial rn
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
		Clipboard.copy(NEWLINE + emote)
	end
end
Emoter.new("test").copy