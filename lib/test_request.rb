# -*- encoding : utf-8 -*-
require "uri"
require "net/http"
require 'json'

URL_CNC = URI.parse("http://localhost:5665/")

def uploader
        fname = ARGV[0]
        uri = URI.parse( URL_CNC.to_s )
        req = Net::HTTP::Post.new("#{URL_CNC}api/v1/requests")
        # req = Net::HTTP::Post.new("#{URL_CNC}workout/abs?id=1234")
        req.add_field('User-Agent', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16')
        req.add_field('Accept', '*/*')
        req.add_field('Content-Type', 'application/json')

        data = "{email: 'test', fio: 'test_fio', subject: 'test_subject', message: 'test_message'}".to_json
        req.body = data
        req.add_field('Content-Length', data.length )

        res = Net::HTTP.start( uri.host, uri.port ) {|http|
          http.request(req)
        }

        check_response_code( res.code )
end

def check_response_code( code )
        case code
                when '200' then puts "OK: Sucessfully uploaded - #{code}"
                when '302' then puts "Redirected - #{code}"
                when '400' then puts "Bad Request - #{code}"
                when '404' then puts "Not found - #{code}"
                else puts "UNKNOWN ERROR - #{code}"
        end
end

uploader