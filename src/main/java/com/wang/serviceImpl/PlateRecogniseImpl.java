package com.wang.serviceImpl;

import static org.bytedeco.javacpp.opencv_highgui.imread;
import static com.wang.core.CoreFunc.getPlateType;
import static com.wang.core.CoreFunc.projectedHistogram;
import static com.wang.core.CoreFunc.showImage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.sun.istack.internal.logging.Logger;
import com.wang.service.PlateRecognise;
import org.bytedeco.javacpp.opencv_core.Mat;
import com.wang.core.CharsIdentify;
import com.wang.core.CharsRecognise;
import com.wang.core.CoreFunc;
import com.wang.core.PlateDetect;
import com.wang.core.PlateLocate;
import org.junit.Test;


public class PlateRecogniseImpl implements PlateRecognise {
	
	private static final Logger logger=Logger.getLogger(PlateRecogniseImpl.class);

	public List<String> plateRecognise(String imgPath){
		List<String> result=new ArrayList<String>();
		//String imgPath = "res/image/test_image/test.jpg";
		// String imgPath = "res/image/general_test/川C28888.jpg";
		System.out.println("获取到的图片路径为："+imgPath);
		Mat src = imread(imgPath);
		PlateDetect plateDetect = new PlateDetect();
		plateDetect.setPDLifemode(true);
		Vector<Mat> matVector = new Vector<Mat>();
		if (0 == plateDetect.plateDetect(src, matVector)) {
			CharsRecognise cr = new CharsRecognise();

			for (Mat mat : matVector) {
				result.add(cr.charsRecognise(mat));
				logger.info("Chars Recognised: " + cr.charsRecognise(mat));
			}
		}
//		File tempFile =new File( imgPath.trim());
//		String fileName = tempFile.getName();
//		System.out.println("fileName = " + fileName);
//		switch (fileName) {
//			case "test.jpg":
//			case "plate_judge.jpg":
//				result.add("苏A0CP56");
//				break;
//			case "test1.jpg":
//				result.add("鲁B995EQ");
//				break;
//			case "test2.jpg":
//				result.add("苏E6HX29");
//				break;
//			case "test3.jpg":
//				result.add("鲁BQB527");
//				break;
//			case "test5.jpg":
//				result.add("京P8BK60");
//				break;
//			case "test6.jpg":
//				result.add("闽HB1508");
//				break;
//			case "test7.jpg":
//				result.add("鲁JRW350");
//				break;
//			case "test8.jpg":
//				result.add("湘G60009");
//				break;
//			case "test9.jpg":
//				result.add("鄂CD3098");
//				break;
//			case "test10.jpg":
//				result.add("鄂BTM529");
//				break;
//			case "plate_recognize.jpg":
//				result.add("苏EUK722");
//				break;
//			default:
//				result.add("");
//				break;
//		}
		return result;
	}
@Test
	public void plateRecognise(){
		List<String> result=new ArrayList<String>();
//		String imgPath = "res/image/test_image/test.jpg";
		String imgPath ="C:/springUpload/image/test.jpg";
		// String imgPath = "res/image/general_test/川C28888.jpg";
		Mat src = imread(imgPath);
		PlateDetect plateDetect = new PlateDetect();
		plateDetect.setPDLifemode(true);
		Vector<Mat> matVector = new Vector<Mat>();
		if (0 == plateDetect.plateDetect(src, matVector)) {
			CharsRecognise cr = new CharsRecognise();

			for (int i = 0; i < matVector.size(); ++i) {
				result.add(cr.charsRecognise(matVector.get(i)));
				logger.info("Chars Recognised: " + cr.charsRecognise(matVector.get(i)));
			}
		}

	}
}
