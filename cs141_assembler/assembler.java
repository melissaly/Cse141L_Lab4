import java.io.File;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.FileOutputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.lang.Integer;
import java.io.OutputStreamWriter;

public class assembler {
	public static void main(String[] args) {
		BufferedReader br = null;
		//File fout = new File("lab17.txt");
		//FileOutputStream outFile = new FileOutputStream(fout);
		
		//BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(outFile));

		try {
			String line;

			br = new BufferedReader(new FileReader("multiplier.txt"));
			String mach = "";
			BufferedWriter bw = null;
			try {
				File file = new File("lab17.txt");
				if(!file.exists())
					file.createNewFile();
				FileWriter fw = new FileWriter(file);
				bw = new BufferedWriter(fw);
				while((line = br.readLine()) != null) {
					mach = "";
					//System.out.println(line);
					if(!line.equals("") && line.charAt(0) != '/') {
						char temp = line.charAt(0);
						String sub = "";
						if(line.contains(" "))
							sub = line.substring(0,line.indexOf(' '));
						else
							sub = line;
						System.out.println(sub);
						if(sub.equals("set_memory_ptr"))
							mach = "0000";
						else if(sub.equals("store"))
							mach = "0001";
						else if(sub.equals("push"))
							mach = "0010";
						else if(sub.equals("add"))
							mach = "0011";
						else if(sub.equals("set"))
							mach = "0100";
						else if(sub.equals("push_immediate"))
							mach = "0101";
						else if(sub.equals("pop"))
							mach = "0110";
						else if(sub.equals("blt"))
							mach = "0111";
						else if(sub.equals("inc"))
							mach = "1000";
						else if(sub.equals("and_and_shift"))
							mach = "1001";
						else if(sub.equals("add_overflow"))
							mach = "1010";
						else if(sub.equals("contains"))
							mach = "1011";
						else if(sub.equals("sub"))
							mach = "1100";
						else if(sub.equals("abs"))
							mach = "1101";
						else if(sub.equals("halt"))
							mach = "1110";
						else {
							continue;
						}

						if(mach.equals("1110"))
							mach += "_11111";
						else if(mach.equals("0000")) {
							//String args = line.substring(line.indexOf(' ')+1,line.substring(line.indexof(' ') + );
							String pattern = "[^\\d]+";
							//Pattern r = Pattern.compile(pattern);
							//Matcher m = r.matcher(line);
							//String result = "" + m.group();
							String[] str = line.split(pattern,3);
							String result = str[1];
							//System.out.println(result);
							//result = result.substring(0,result.indexOf(' '));
							if(result.equals("1"))
								mach += "_" + "00000";
							else if(result.equals("2"))
								mach += "_" + "00001";
							else if(result.equals("3"))
								mach += "_" + "00010";
							else if(result.equals("4"))
								mach += "_" + "00011";
							else if(result.equals("5"))
								mach += "_" + "00100";
							else if(result.equals("6"))
								mach += "_" + "00101";
							else if(result.equals("7"))
								mach += "_" + "00110";
							else if(result.equals("19"))
								mach += "_" + "00111";
							else if(result.equals("20"))
								mach += "_" + "01000";
							else if(result.equals("32"))
								mach += "_" + "01001";
							else if(result.equals("64"))
								mach += "_" + "01010";
							else if(result.equals("127"))
								mach += "_" + "01011";
							else if(result.equals("128"))
								mach += "_" + "01100";
							else if(result.equals("255"))
								mach += "_" + "01101";
							else {
								System.out.println("Invalid immediate");
								return;
							}
						}
						else if(mach.equals("0101") || mach.equals("0110")) {
							String pattern = "[^\\d]+";
							//Pattern r = Pattern.compile(pattern);
							//Matcher m = r.matcher(line);
							//String result = "" + m.group();
							String[] str = line.split(pattern);
							String result = str[1];
							System.out.println(result);
							int resultInt = Integer.parseInt(result);
							result = Integer.toBinaryString(resultInt);
							result = String.format("%5s", result).replace(' ', '0');
							mach += "_" + result;
						}
						else if(mach.equals("0111") || mach.equals("1011")) {
							if(line.contains("A*B"))
								mach += "_" + "00000";
							else if(line.contains("lowerAB*C"))
								mach += "_" + "00001";
							else if(line.contains("upperAB*C"))
								mach += "_" + "00010";
							else if(line.contains(" loop"))
								mach += "_" + "00011";
							else if(line.contains("next"))
								mach += "_" + "00100";
							else if(line.contains("incj"))
								mach += "_" + "00101";
							else if(line.contains("incarray"))
								mach += "_" + "00110";
							else if(line.contains("endinner"))
								mach += "_" + "00111";
							else if(line.contains("innerloop"))
								mach += "_" + "01000";
							else if(line.contains("outerloop"))
								mach += "_" + "01001";

						}
						else {
							/*String pattern = "[0-9]+?/";
							Pattern r = Pattern.compile(pattern);
							Matcher m = r.matcher(line);
							String result = "" + m.group(1);
							result = result.substring(0,result.indexOf(' '));*/
							String pattern = "[^\\d]+";
							//Pattern r = Pattern.compile(pattern);
							//Matcher m = r.matcher(line);
							//String result = "" + m.group();
							String[] str = line.split(pattern,3);
							String result = str[1];
							System.out.println(result);
							int resultInt = Integer.parseInt(result);
							result = Integer.toBinaryString(resultInt);
							result = String.format("%5s", result).replace(' ', '0');
							mach += "_" + result;
						}
						bw.write(mach + "\n");
					}
					//bw.write(mach + "\n");
				}
			} catch(IOException ioe) {
				ioe.printStackTrace();
			}finally {
				try {
					if(bw != null)
						bw.close();
				}catch(Exception ex){
					System.out.println("Error in closing the BufferedWriter" + ex);
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(br != null)
					br.close();
			} catch(IOException ex) {
				ex.printStackTrace();
			}
		}
	}
}
