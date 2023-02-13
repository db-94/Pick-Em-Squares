require 'json'

json = JSON.parse(File.read('./projects/pools.json'))

picks = {}

json["10"]["picks"].each_with_index do |pick, y|
    pick.each_with_index do |person, x|
        if picks[person] == nil
            picks[person] = {
                '10' => [],
                '25' => []
            }
        end
        points = []
        points << [json["10"]["nfc"]["q1"][y], json["10"]["afc"]["q1"][x+5]]
        points << [json["10"]["nfc"]["q2"][y], json["10"]["afc"]["q2"][x+5]]
        points << [json["10"]["nfc"]["q3"][y], json["10"]["afc"]["q3"][x+5]]
        points << [json["10"]["nfc"]["m2"][y], json["10"]["afc"]["m2"][x+5]]
        points << [json["10"]["nfc"]["q4"][y], json["10"]["afc"]["q4"][x+5]]
        picks[person]['10'] << points
    end
end

json["25"]["picks"].each_with_index do |pick, y|
    pick.each_with_index do |person, x|
        if picks[person] == nil
            picks[person] = {
                '10' => [],
                '25' => []
            }
        end
        points = []
        points << [json["25"]["nfc"]["q1"][y], json["25"]["afc"]["q1"][x+5]]
        points << [json["25"]["nfc"]["q2"][y], json["25"]["afc"]["q2"][x+5]]
        points << [json["25"]["nfc"]["q3"][y], json["25"]["afc"]["q3"][x+5]]
        points << [json["25"]["nfc"]["m2"][y], json["25"]["afc"]["m2"][x+5]]
        points << [json["25"]["nfc"]["q4"][y], json["25"]["afc"]["q4"][x+5]]
        picks[person]['25'] << points
    end
end
