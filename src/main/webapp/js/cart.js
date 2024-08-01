/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.querySelector('.button-paypal').addEventListener('click', function (event) {
    var fullname = document.getElementById('first').value.trim();
    var address = document.getElementById('company').value.trim();
    var phone = document.getElementById('phone').value.trim();
    var checkbox = document.getElementById('f-option4');
    var paymentMethod1 = document.getElementById('f-option5');
    var paymentMethod2 = document.getElementById('f-option6');

    var errorMessages = '';

    if (fullname === '') {
        errorMessages = 'Vui lòng nhập Họ và Tên.';
    } else if (address === '') {
        errorMessages = 'Vui lòng nhập Địa Chỉ.';
    } else if (phone === '') {
        errorMessages = 'Vui lòng nhập Số Điện Thoại.';
    } else if (!paymentMethod1.checked && !paymentMethod2.checked) {
        errorMessages = 'Vui lòng chọn ít nhất một phương thức thanh toán.';
    } else if (!checkbox.checked) {
        errorMessages = 'Vui lòng đánh dấu vào ô "Tôi đã đọc và xác nhận mọi thông tin đều chính xác".';
    }

    if (errorMessages !== '') {
        event.preventDefault(); // Ngăn chặn hành động mặc định của nút "Tiếp Tục"
        document.getElementById('submitError').innerHTML = errorMessages; // Hiển thị thông báo lỗi
    } else {
        document.getElementById('submitError').innerHTML = ''; // Xóa thông báo lỗi nếu không có lỗi
        // Chuyển hướng người dùng về trang "Home"
        window.location.href = 'home';
    }
});
function saveAddress(shipId) {
    var editedAddressInput = document.getElementById('address-' + shipId);

    var newAddress = editedAddressInput.value; // Get the edited address value
    var addressSpan = document.getElementById('address');
    addressSpan.innerText = newAddress; // Update the address shown on the web page

    var hiddenAddressInput = document.getElementById('hiddenAddressInput');
    hiddenAddressInput.value = newAddress;
    console.log(hiddenAddressInput);

    var modal = document.getElementById('addressModal');
    modal.style.display = 'none'; // Close the modal after saving

}

function editAddress() {
    var modal = document.getElementById('addressModal');
    modal.style.display = 'block';
}
var closeModal = document.getElementsByClassName('close')[0];

closeModal.onclick = function () {
    var modal = document.getElementById('addressModal');
    modal.style.display = 'none';
};

function deleteItem(shipId) {
    // Gửi yêu cầu xóa bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=delete&shipId=' + shipId, true);

    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            // Tải lại nội dung của popup
            reloadAddressModal();
        } else {
            alert('Đã xảy ra lỗi khi xóa mục. Vui lòng thử lại sau.');
        }
    };

    xhr.send();
}

function reloadAddressModal() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'cartcontact', true); // Thay đổi thành phương thức hoặc URL phù hợp để tải lại dữ liệu
    xhr.onload = function () {
        if (xhr.status === 200) {
            var parser = new DOMParser();
            var newDoc = parser.parseFromString(xhr.responseText, 'text/html');
            var newModalContent = newDoc.getElementById('addressModal');
            var currentModal = document.getElementById('addressModal');

            // Thay thế nội dung của popup hiện tại bằng nội dung mới
            currentModal.innerHTML = newModalContent.innerHTML;

            // Sau khi tải lại, cần gắn lại sự kiện cho các nút trong popup
            attachModalEvents();
        } else {
            alert('Đã xảy ra lỗi khi tải lại popup. Vui lòng thử lại sau.');
        }
    };
    xhr.send();
}

function attachModalEvents() {
    // Gắn lại sự kiện cho nút Sửa, Xóa, Chọn, và các nút khác trong popup
    var editButtons = document.querySelectorAll('.edit-btn');
    editButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            // Xử lý sự kiện khi nhấn nút Sửa
        });
    });

    var deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var shipId = this.getAttribute('data-shipId');
            deleteItem(shipId); // Gọi lại hàm xóa với shipId tương ứng
        });
    });

    var selectButtons = document.querySelectorAll('.btn-success');
    selectButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var shipId = this.getAttribute('data-shipId');
            saveAddress(shipId); // Gọi lại hàm lưu địa chỉ với shipId tương ứng
        });
    });

    var closeModal = document.querySelector('.close');
    closeModal.addEventListener('click', function () {
        var modal = document.getElementById('addressModal');
        modal.style.display = 'none';
    });
}

// Gọi hàm attachModalEvents lần đầu khi trang được tải
attachModalEvents();


function editAddressInput(shipId) {
    // Tìm input và nút cập nhật tương ứng với shipId
    var addressInput = document.getElementById('address-' + shipId);
    var updateButton = document.getElementById('updateBtn-' + shipId);

    if (addressInput && updateButton) {
        // Ẩn đi input readonly
        addressInput.readOnly = false;

        // Hiển thị nút Cập Nhật
        updateButton.style.display = 'block';
    }
}

function updateAddress(shipId) {
    var addressInput = document.getElementById(`address-` + shipId);
    var updateBtn = document.getElementById(`updateBtn-` + shipId);
    // Lấy giá trị của input
    var newAddress = addressInput.value;
    // Chuyển input thành chỉ đọc (readonly)
    addressInput.readOnly = true;
    // Ẩn nút "Cập Nhật"
    updateBtn.style.display = 'none';

    // Gửi yêu cầu xóa bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=update&shipId=' + shipId + '&newAddress=' + newAddress, true);

    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            // Tải lại nội dung của popup
            reloadAddressModal();
        } else {
            alert('Đã xảy ra lỗi khi xóa mục. Vui lòng thử lại sau.');
        }
    };

    xhr.send();
}
function addNewAddress() {
    var newAddress = document.getElementById('add-address').value.trim();
    // Check if the new address is not empty
    if (newAddress === '') {
        alert('Please enter a valid address.');
        return;
    }
    // Gửi yêu cầu bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=add&address=' + newAddress, true);
    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            document.getElementById('add-address').value = ''; // Clear the input field
            // Tải lại nội dung của popup
            reloadAddressModal(); // Ensure this function is defined
        } else {
            alert('Đã xảy ra lỗi khi thêm địa chỉ. Vui lòng thử lại sau.');
        }
    };

    xhr.send();
}
function editAddress1() {
    var modal = document.getElementById('addressModal1');
    modal.style.display = 'block';
}
var closeModal = document.getElementsByClassName('close1')[0];
closeModal.onclick = function () {
    var modal = document.getElementById('addressModal1');
    modal.style.display = 'none';
};
function addNewAddress1() {
    var phone = document.getElementById('add-phone').value.trim();
    // Check if the new address is not empty
    var phonePattern = /^\d{10,}$/;
    if (!phonePattern.test(phone)) {
        alert('Vui lòng nhập số điện thoại hợp lệ.');
        return;
    }
    // Gửi yêu cầu bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=add&phone=' + phone, true);
    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            document.getElementById('add-phone').value = ''; // Clear the input field
            // Tải lại nội dung của popup
            reloadAddressModal1(); // Ensure this function is defined
        } else {
            alert('Đã xảy ra lỗi khi thêm địa chỉ. Vui lòng thử lại sau.');
        }
    };
    xhr.send();
}
function saveAddress1(shipId) {
    var editedAddressInput = document.getElementById('phone-' + shipId);

    var newAddress = editedAddressInput.value; // Get the edited address value
    var addressSpan = document.getElementById('phone');
    addressSpan.innerText = newAddress; // Update the address shown on the web page
    
    var hiddenPhoneInput = document.getElementById('hiddenPhoneInput');
    hiddenPhoneInput.value = newAddress;
    console.log(hiddenPhoneInput);
    
    var modal = document.getElementById('addressModal1');
    modal.style.display = 'none'; // Close the modal after saving

}
function editAddressInput1(shipId) {
    // Tìm input và nút cập nhật tương ứng với shipId
    var addressInput = document.getElementById('phone-' + shipId);
    var updateButton = document.getElementById('updateBtn1-' + shipId);

    if (addressInput && updateButton) {
        // Ẩn đi input readonly
        addressInput.readOnly = false;

        // Hiển thị nút Cập Nhật
        updateButton.style.display = 'block';
    }
}
function updateAddress1(shipId) {
    var addressInput = document.getElementById(`phone-` + shipId);
    var updateBtn = document.getElementById(`updateBtn1-` + shipId);
    // Lấy giá trị của input
    var newPhone = addressInput.value;
    // Chuyển input thành chỉ đọc (readonly)
    addressInput.readOnly = true;
    // Ẩn nút "Cập Nhật"
    updateBtn.style.display = 'none';

    // Gửi yêu cầu xóa bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=update&shipId=' + shipId + '&newPhone=' + newPhone, true);

    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            // Tải lại nội dung của popup
            reloadAddressModal1();
        } else {
            alert('Đã xảy ra lỗi khi xóa mục. Vui lòng thử lại sau.');
        }
    };

    xhr.send();
}
function deleteItem1(shipId) {
    // Gửi yêu cầu xóa bằng AJAX
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'cartcontact?service=delete&shipId=' + shipId, true);

    // Xử lý khi nhận được phản hồi từ server
    xhr.onload = function () {
        if (xhr.status === 200) {
            // Tải lại nội dung của popup
            reloadAddressModal1();
        } else {
            alert('Đã xảy ra lỗi khi xóa mục. Vui lòng thử lại sau.');
        }
    };

    xhr.send();
}
function reloadAddressModal1() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'cartcontact', true); // Thay đổi thành phương thức hoặc URL phù hợp để tải lại dữ liệu
    xhr.onload = function () {
        if (xhr.status === 200) {
            var parser = new DOMParser();
            var newDoc = parser.parseFromString(xhr.responseText, 'text/html');
            var newModalContent = newDoc.getElementById('addressModal1');
            var currentModal = document.getElementById('addressModal1');

            // Thay thế nội dung của popup hiện tại bằng nội dung mới
            currentModal.innerHTML = newModalContent.innerHTML;

            // Sau khi tải lại, cần gắn lại sự kiện cho các nút trong popup
            attachModalEvents1();
        } else {
            alert('Đã xảy ra lỗi khi tải lại popup. Vui lòng thử lại sau.');
        }
    };
    xhr.send();
}

function attachModalEvents1() {
    // Gắn lại sự kiện cho nút Sửa, Xóa, Chọn, và các nút khác trong popup
    var editButtons = document.querySelectorAll('.edit-btn');
    editButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            // Xử lý sự kiện khi nhấn nút Sửa
        });
    });

    var deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var shipId = this.getAttribute('data-shipId');
            deleteItem1(shipId); // Gọi lại hàm xóa với shipId tương ứng
        });
    });

    var selectButtons = document.querySelectorAll('.btn-success');
    selectButtons.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var shipId = this.getAttribute('data-shipId');
            saveAddress1(shipId); // Gọi lại hàm lưu địa chỉ với shipId tương ứng
        });
    });

    var closeModal = document.querySelector('.close');
    closeModal.addEventListener('click', function () {
        var modal = document.getElementById('addressModal1');
        modal.style.display = 'none';
    });
}

// Gọi hàm attachModalEvents lần đầu khi trang được tải
attachModalEvents1();


