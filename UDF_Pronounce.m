function UDF_Pronounce(msg)

    caUserInput = char(msg);
    NET.addAssembly('System.Speech');
    obj = System.Speech.Synthesis.SpeechSynthesizer;
    obj.Volume = 100;
    Speak(obj, caUserInput);
    
end