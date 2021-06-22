''' Các hàm được định nghĩa trong gói chương trình
1) Tải dữ liệu từ đường link trong gói constants
2) Tiền xử lý số liệu trong dataframe
3) Chuyển dữ liệu theo phương pháp minmax hoặc chuẩn hóa
4) Chia dữ liệu ban đầu thành hai tập training và testing với tỷ lệ thích hợp
'''


from constants import *	# Tải một số chương trình lệnh dùng chung
import skimage.io


def image1_load(path: str):
    '''Đọc ảnh một chiều
    :path: Đường dẫn đến dữ liệu ảnh cần tải
    :output: list các điểm ảnh chứa trong các narray
    '''
    import glob     # (pip install glob2)
    images = [skimage.io.imread(file, as_gray=True) for file in glob.glob(path)]
    print("Hoàn thành việc tải dữ liệu hình ảnh một chiều")
    return images

def imageRGB_load(path: str):
    '''Đọc ảnh ba chiều
    :path: Đường dẫn đến dữ liệu ảnh cần tải
    :output: list các điểm ảnh chứa trong các narray
    '''
    import glob     
    images = [skimage.io.imread(file) for file in glob.glob(path)]
    print("Hoàn thành việc tải dữ liệu hình ảnh ba chiều")
    return images

# Lệnh in tất cả các ảnh đã được tải vào Python
#for i in range(len(img)):
#    cv2.imshow("image", img[i])
#    cv2.waitKey(0)
#    cv2.destroyAllWindows()


